function fixedPoint = getFixedPoint(myVectorField,guess,tolerance)
err = Inf;

while abs(err) > tolerance
    myJac = jacobianest(myVectorField,guess;
    newGuess = guess' - myJac ^ -1 * myVectorField(guess)';
    err = guess - newGuess';
    guess = newGuess;
end

fixedPoint = guess;