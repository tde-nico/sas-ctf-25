class Instruction:
	def __init__(self, addr, opcode, operands):
		self.addr = addr
		self.opcode = opcode
		self.operands = operands
		self.v0 = operands[0]
		self.v1 = operands[1]
		self.v2 = operands[2]
		self.str = None
		self.ra = f'r{self.v0}'
		self.rb = f'r{self.v1}'
		self.rc = f'r{self.v2}'
	
	def gen_str(self):
		self.str = f"{self.opcode:02x} {self.v0:02x} {self.v1:02x} {self.v2:04x}"
		op = self.opcode
		v0 = self.v0
		v1 = self.v1
		v2 = self.v2
		ra = self.ra
		rb = self.rb
		rc = self.rc

		if op == 1:
			s = f'addi64 {ra}, {rb}, 0x{(v2):016x}'
		elif op == 2:
			s = f'st64 {ra}, [{rb} + 0x{v2:04x}]'
		elif op == 3:
			s = f'movi {ra}, 0x{(((v1 | v2 << 8) << 12) & 0xffffffff):08x}'
		elif op == 4:
			s = f'add {ra}, {rb}, {rc}'
		elif op == 5:
			s = f'st32 {ra}, [{rb} + 0x{v2:04x}]'
		elif op == 6:
			s = f'jmp 0x{v2:02x}{v1:02x}{v0:02x}'
		elif op == 7:
			s = f'ld32 {ra}, [{rb} + 0x{v2:04x}]'
		elif op == 8:
			s = f'shl {ra}, {rb}, 0x{(v2 & 0xff):02x}'
		elif op == 9:
			s = f'ld64 {ra}, [{rb} + 0x{v2:04x}]'
		elif op == 10:
			s = f'bgez {ra}, 0x{v2:04x}{v1:02x}'
		elif op == 11:
			s = f'xor {ra}, {rb}, {rc}'
		elif op == 12:
			s = f'addi32 {ra}, {rb}, 0x{v2:04x}'
		elif op == 13:
			s = f'sext32 {ra}, {rb}'
		elif op == 14:
			s = f'bge {ra}, {rb}, 0x{v2:04x}'
		elif op == 15:
			s = f'shr {ra}, {rb}, 0x{(v2 & 0xff):02x}'
		elif op == 16:
			s = f'andi {ra}, {rb}, 0x{(v2 & 0xff):02x}'
		elif op == 17:
			s = f'ldb {ra}, [{rb} + 0x{v2:04x}]'
		elif op == 18:
			s = f'stb {ra}, [{rb} + 0x{v2:04x}]'
		elif op == 19:
			s = f'bnez {ra}, 0x{v2:04x}{v1:02x}'
		elif op == 20:
			s = f'mov {ra}, {rb}'
		elif op == 21:
			s = f'nop'
		elif op == 22:
			s = f'bge {ra}, {rb}, 0x{v2:04x}'
		elif op == 23:
			s = f'shli32 {ra}, {rb}, 0x{(v2 & 0xff):02x}'
		elif op == 24:
			s = f'shlv {ra}, {rb}, {rc}'
		elif op == 25:
			s = f'or {ra}, {rb}, {rc}'
		elif op == 26:
			s = f'blt {ra}, {rb}, 0x{v2:04x}'
		elif op == 27:
			s = f'shri32 {ra}, {rb}, 0x{(v2 & 0xff):02x}'
		elif op == 28:
			s = f'mul32 {ra}, {rb}'
		elif op == 29:
			s = f'ld32 {ra}, [{rb} + 0x{v2:04x}]'
		else:
			s = f'unknown opcode {self.str}'
		
		try:
			self.str = s
		except UnboundLocalError:
			print(f'unknown opcode {self.str}')
			exit(1)


	def __repr__(self):
		self.gen_str()
		return f"{self.addr:04x}: {self.str}"

# with open("bytecode.txt", 'r') as f:
# 	bytecode = f.read().strip().split('\n')

with open("raw_bytecode.txt", 'r') as f:
	bytecode = f.read().strip().split('\n')

code = []
addr = 0
for line in bytecode:
	line = line.strip()[2:]
	opcode = int(line[-2:], 16)
	operands = [int(line[-4:-2], 16), int(line[-6:-4], 16), int(line[:-6], 16)]
	# line.split(' ')
	# addr, opcode, *operands = line.split()
	# addr = int(addr[:-1], 16)
	# opcode = int(opcode, 16)
	# operands = [int(op, 16) for op in operands]
	code.append(Instruction(addr, opcode, operands))
	addr += 1

for instr in code:
	print(instr)
