'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { CheckCircle, Lock, PlayCircle } from 'lucide-react';
import { SagaMap, SagaLevel } from '@/components/gamification/SagaMap';
import { cn } from '@/lib/utils';
import { createClient } from '@supabase/supabase-js';
import { Database } from '@/types/supabase';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co';
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder';
const supabase = createClient<Database>(supabaseUrl, supabaseKey);

import { MOCK_QUIZZES } from '@/lib/mockData';

export default function Dashboard() {
  const [levels, setLevels] = useState<SagaLevel[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchSagaState() {
      try {
        // 1. Fetch User Progress directly
        const { data: { user } } = await supabase.auth.getUser();
        let completedIds = new Set<string>();

        if (user) {
          const { data: progressData, error: progressError } = await supabase
            .from('user_progress')
            .select('quiz_id')
            .eq('user_id', user.id)
            .eq('status', 'completed');

          if (progressData) {
            progressData.forEach(p => completedIds.add(p.quiz_id));
          }
        }

        // 2. Use MOCK_QUIZZES as the source of truth for Level Structure
        const rawLevels: SagaLevel[] = MOCK_QUIZZES.map((q, index) => ({
          id: q.id,
          day_number: index + 1,
          title: q.title,
          is_boss_level: q.is_special_mission || false, // Map special mission to boss level visual
          xp_reward: q.xpReward,
          module_title: q.id === '1' || q.id === '2' || q.id === '3' ? 'Week 1: Foundations' :
            q.id === '4' ? 'Week 2: Social Engineering' : 'Week 3: Deepfakes',
          theme_color: null,
          order_index: index,
          status: 'locked'
        }));

        // 3. Determine Status & Max Day
        let maxUnlockedDay = 0;
        let isNextUnlocked = true; // The first non-completed level is the active one

        console.log('🔍 Debug: Completed IDs found:', Array.from(completedIds));

        const processedLevels: SagaLevel[] = rawLevels.map((l) => {
          const isCompleted = completedIds.has(l.id);
          let status: 'locked' | 'active' | 'completed' = 'locked';

          if (isCompleted) {
            status = 'completed';
            maxUnlockedDay = Math.max(maxUnlockedDay, l.day_number);
          } else if (isNextUnlocked) {
            status = 'active';
            maxUnlockedDay = Math.max(maxUnlockedDay, l.day_number);
            isNextUnlocked = false;
          }

          return { ...l, status };
        });

        console.log('🔍 Debug: Processed Levels:', processedLevels.map(l => `${l.id}: ${l.status}`));

        // 4. Fog of War Filter
        const uniqueModules = Array.from(new Set(processedLevels.map(l => l.module_title)));
        const currentLevelObj = processedLevels.find(l => l.day_number === maxUnlockedDay) || processedLevels[0];
        const currentModuleIndex = uniqueModules.indexOf(currentLevelObj.module_title);
        const targetIndex = currentModuleIndex === -1 ? 0 : currentModuleIndex;
        const visibleModules = uniqueModules.slice(0, targetIndex + 2);
        const visibleLevels = processedLevels.filter(l => visibleModules.includes(l.module_title));

        setLevels(visibleLevels);
      } catch (err) {
        console.error('Unexpected error:', err);
      } finally {
        setLoading(false);
      }
    }

    fetchSagaState();

    const handleFocus = () => {
      console.log('🔄 Tab focused, refreshing saga state...');
      fetchSagaState();
    };

    window.addEventListener('focus', handleFocus);
    return () => window.removeEventListener('focus', handleFocus);
  }, []);

  if (loading) {
    return <div className="p-8 text-center">Loading your journey...</div>;
  }

  return (
    <div className="space-y-6">
      <div className="text-center space-y-2">
        <h1 className="text-2xl font-bold">Your Journey</h1>
        <p className="text-zinc-500 dark:text-zinc-400">Master AI Safety one step at a time.</p>
      </div>

      {/* Pending Challenges Notification */}
      <div className="bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 p-4 rounded-xl flex items-center justify-between animate-in slide-in-from-top-4">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-yellow-100 dark:bg-yellow-800 rounded-full flex items-center justify-center text-xl">
            ⚔️
          </div>
          <div>
            <h3 className="font-bold text-sm text-yellow-900 dark:text-yellow-100">New Challenge!</h3>
            <p className="text-xs text-yellow-700 dark:text-yellow-300">DeepLearner challenged you.</p>
          </div>
        </div>
        <Link
          href="/quiz/1"
          className="px-4 py-2 bg-yellow-500 hover:bg-yellow-600 text-white text-sm font-bold rounded-lg transition-colors"
        >
          Accept
        </Link>
      </div>

      {/* Learning Path */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-xl font-bold">Saga Map</h2>
          <span className="text-sm text-zinc-500">Week 1-4</span>
        </div>

        <SagaMap levels={levels} />
      </div>
    </div>
  );
}
