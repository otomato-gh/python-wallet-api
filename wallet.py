import logging

class InsufficientAmount(Exception):
    pass


class Wallet(object):

    def __init__(self, initial_amount=0):
        logging.info('Initializing')
        self.balance = initial_amount

    def spend_cash(self, amount):
        logging.info('Spending')
        if self.balance < amount:
            raise InsufficientAmount('Not enough available to spend {}'.format(amount))
        self.balance -= amount

    def add_cash(self, amount):
        logging.info('Mo money!')
        self.balance += amount
  
    def get_balance(self):
        return self.balance
