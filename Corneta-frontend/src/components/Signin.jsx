import React from 'react';
import { Box, Text, Button } from '@blockstack/ui';
import { authenticate } from '../auth';

const start = {
  padding: 8,
  backgroundColor: '#3498db',
  color: '#fff',
  borderRadius: 4
}
export const Signin = () => {
  return (
    <Box width="100%" textAlign="center">
      <Box maxWidth="800px" mx="auto" mt={[6, '100px']}>
        <Text fontWeight="700" fontSize={['36px', '50px']} lineHeight={1} display="block">
          Faca login na sua carteira pra acessar...
        </Text>
        <Box mt={[5, '60px']}>
          <Button onClick={() => authenticate()} style={start}>
            <Text textStyle="display.large" fontSize={3}>Iniciar</Text>
          </Button>
        </Box>
      </Box>
    </Box>
  );
};
