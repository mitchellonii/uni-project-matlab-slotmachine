initialAmount = 1000; 

fig = figure('Position', [500, 500, 350, 200], 'Name', 'Money Counter', 'NumberTitle', 'off');
    
moneyDisplay = uicontrol('Style', 'text', 'Position', [50, 120, 250, 30], 'String', ['Money Left: $', num2str(initialAmount)], 'FontSize', 12);
    
uicontrol('Style', 'text', 'Position', [50, 70, 200, 20], 'String', 'Enter amount to deduct:');
    
inputField = uicontrol('Style', 'edit', 'Position', [50, 40, 200, 30]);
    
uicontrol('Style', 'pushbutton', 'Position', [100, 10, 100, 30], 'String', 'Deduct Money', ...
        'Callback', @(src, event) deductMoney(inputField, moneyDisplay, initialAmount));



function deductMoney(inputField, moneyDisplay, initialAmount)
    amountToDeduct = str2double(get(inputField, 'String'));
    
    if isnan(amountToDeduct) || amountToDeduct <= 0
        msgbox('Please enter a valid amount to deduct.', 'Error', 'error');
        return;
    end
    
    newAmount = initialAmount - amountToDeduct;
    assignin('base','initialAmount',newAmount);
    if newAmount < 0
        msgbox('Insufficient funds! You cannot deduct more than the available balance.', 'Error', 'error');
        return;
    end
        set(moneyDisplay, 'String', ['Money Left: $', num2str(newAmount)]);
end
