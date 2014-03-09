function fixedPoint = fixedPointPrompt(fixedPointGuess)

if isvector(fixedPointGuess) && isequal(size(fixedPointGuess),[1 3])
    fixedPoint = getFixedPoint(@myVectorField,fixedPointGuess,1e-10);
    disp(sprintf('The guessed fixed point is [%.2f %.2f %.2f]. If this is correct, hit enter. \n Otherwise, enter a new guess.',fixedPoint))
    newfixedPointGuess = input('Use the format [0 0 0], including the brackets. \n');
    if isempty(newfixedPointGuess)
        fixedPoint = fixedPoint;
    else
        fixedPoint = fixedPointPrompt(newfixedPointGuess);
    end
end

end