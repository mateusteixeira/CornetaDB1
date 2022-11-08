import React from 'react';
import { Flex, Box, Text } from '@blockstack/ui';
import { getPerson, getUserData, userSession } from '../auth';
import { Logo } from './icons/logo';

const Auth = () => {
  if (!userSession.isUserSignedIn()) {
    return null;
  }

  const Avatar = () => {
    const person = getPerson();

    if (person.avatarUrl()) {
      return (
        <Box
          borderRadius="50%"
          width="24px"
          height="24px"
          overflow="hidden"
          mr={2}
        >
          <Box as="img" src={person.avatarUrl()} maxWidth="100%" minHeight="24px" minWidth="24px" />
        </Box>
      );
    }
    return null;
  };

  return (
    <Box>
      <Avatar />
      <Text fontWeight="500">Nome usuario</Text>
      <Text
        fontWeight="600"
        display="inline-block"
        ml={5}
        color="ink.400"
        cursor="pointer"
        onClick={() => {
          userSession.signUserOut();
          window.location = '/';
        }}
      >
        Sair
      </Text>
    </Box>
  );
};

export const Header = () => {
  return (
    <Flex width="100%" justifyContent="space-between" px={4} py={3}>
      <Box onClick={() => (document.location = '/')} cursor="pointer">
        <div style={{ display: 'flex', alignItems: 'center' }}>
          <Logo />
          <Text fontWeight="600">
            Corneta
          </Text>
        </div>
      </Box>
      <Auth />
    </Flex>
  );
};
