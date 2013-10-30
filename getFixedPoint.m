function fixedPoint = getFixedPoint(myVectorField,guess,tolerance)
err = Inf;

currentOutput = myVectorField(guess);
if norm(currentOutput) ~= 0
    while abs(err) > tolerance
        myJac = jacobianest(myVectorField,guess);
        newGuess = guess' - myJac ^ -1 * myVectorField(guess)';
        err = guess - newGuess';
        guess = newGuess';
    end
end

fixedPoint = guess';