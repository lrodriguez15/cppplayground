#include "gtest/gtest.h"
#include "dummy/dummy.h"

TEST(example, add) // NOLINT
{
    double res;
    res = add_numbers(1.0, 2.0);
    ASSERT_NEAR(res, 3.0, 1.0e-11); // NOLINT
}

TEST(example, subtract) // NOLINT
{
    double res;
    res = subtract_numbers(1.0, 2.0);
    ASSERT_NEAR(res, -1.0, 1.0e-11); // NOLINT
}

TEST(example, multiply) // NOLINT
{
    double res; 
    res = multiply_numbers(1.0, 1.0);
    EXPECT_DOUBLE_EQ(res, 1.0); // NOLINT
}