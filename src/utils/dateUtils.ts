export const getToday = (): string => {
    return new Date().toISOString().split('T')[0];
};

export const isYesterday = (dateString: string): boolean => {
    const today = new Date();
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);

    const dateToCheck = new Date(dateString);

    return dateToCheck.toISOString().split('T')[0] === yesterday.toISOString().split('T')[0];
};
