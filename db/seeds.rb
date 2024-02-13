# frozen_string_literal: true

leo = User.create email: 'leo.messi@gmail.com', name: 'Leo Messi'
leo.accounts.create name: 'Salary', amount: 1_000_000

cristiano = User.create email: 'cristiano.ronaldo@gmail.com', name: 'Cristiano Ronaldo'
cristiano.accounts.create name: 'Salary', amount: 1_500_000
