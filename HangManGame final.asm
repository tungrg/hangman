.data
	tbten: .asciiz "Nhap ten nguoi choi: "
	tbfile1: .asciiz "D:/output.txt"
	dausao: .asciiz "*"
	nutgach: .asciiz "-"
	tbtopdau: .asciiz " =====  10 NGUOI DIEM CAO NHAT  ====="
	tblamMenu1: .asciiz "STT      Ten        Diem         Luot choi    \n"
	tblamMenu2: .asciiz "-----------------------------------------\n"
	tbmenu1: .asciiz "\n=== Menu === \n1. Tiep tuc luot choi \n2. Thoat tro choi \n** Lua chon: "
	tbluachonsai: .asciiz " --- Lua chon ko chinh xac. Vui long chon lai!"
	tbtu: .asciiz "Nhap tu can doan: "
	tbxuongdong: .asciiz "\n" 
	tbmenu: .asciiz "\n=== Menu === \n1. Doan ki tu \n2. Doan tu \n** Lua chon: "
	tbfile: .asciiz "D:/input.txt"
	tb1: .asciiz "\nTu can doan gom co "
	tb2: .asciiz " chu cai."
	tb3: .asciiz "Hay doan 1 chu: "
	tbsai: .asciiz "Rat tiec khong co "
	tbdung: .asciiz "Ban da doan dung "
	gameover: .asciiz "Ban da mat het luot :(\nTro choi ket thuc.\n"
	gameover2: .asciiz "Ban da doan sai tu khoa :(\nTro choi ket thuc.\n"
	win: .asciiz "Ban da doan dung tu khoa."
	xuongdong: .asciiz "\n"
	trung: .asciiz "Ban da doan ky tu nay, hay doan ky tu khac."
	diemket: .word 0
	pic1: .space 30
	pic2: .space 30
	pic3: .space 30
	pic4: .space 30
	pic5: .space 30
	pic6: .space 30
	pic7: .space 30
	pic8: .space 30
	pic9: .space 30
	pic10: .space 30
	arr: .space 1000
	stt: .space 1000
	danhsach: .space 1000
	ten: .space 30
	diemso: .word 0
	luotchoi: .word 0
	digits: .space 1000
	string: .space 1000
	tu: .space 30
	luachon: .word 1
	src: .space 1000
	str: .space 1000
	word: .space 1000 # Luu tu can doan
	word2: .space 1000 # Luu cac ky tu da doan duoc
	ss: .space 1000	
	str_end:
.text
	.globl main
main:
	lw $t8,diemso
	lw $t9,luotchoi
Nhaplaiten:
	#xuat tbten
	li $v0,4
	la $a0,tbten
	syscall 
	#nhap ten
	li $v0,8
	la $a0,ten
	la $a1,30
	syscall
	#ten ko chua cac ki tu dac biet
	li $t1,0
	la $s3,'\n'
Lap012345:
	lb $s1,ten($t1)
	beq $s1,$s3,ketthuclap012345
	blt $s1,'0',Nhaplaiten
	bgt $s1,'9',sosanh1
sosanh12:
	bgt $s1,'Z',sosanh2
sosanh23:
	bgt $s1,'z',Nhaplaiten
	j tangdem0123
tangdem0123:
	addi $t1,$t1,1
	j Lap012345
sosanh1:
	blt $s1,'A', Nhaplaiten
	j sosanh12
sosanh2:
	blt $s1,'a', Nhaplaiten
	j sosanh23
ketthuclap012345:
	#Xu li ten
	la $a0,ten
	jal _Xuliten
	
	# Khoi tao do hoa
	addi $t1,$0,0 # Bien dem dia chi
	li $s0,' '
	KhoiTao:
	sb $s0,pic1($t1)
	sb $s0,pic2($t1)
	sb $s0,pic3($t1)
	sb $s0,pic4($t1)
	sb $s0,pic5($t1)
	sb $s0,pic6($t1)
	sb $s0,pic7($t1)
	sb $s0,pic8($t1)
	sb $s0,pic9($t1)
	sb $s0,pic10($t1)
	addi $t1,$t1,1
	bne $t1,7,KhoiTao
	addi $s7,$0,0 #### Bien dem so luot choi
	# Doc file
Random:
	li $v0,42
	addi $a0,$zero,0
	addi $a1,$zero, 3
	syscall
	move $t7,$a0
	beq $t7,0,Random
	#Mo file
	li $v0,13
	la $a0,tbfile
	li $a1,0
	li $a2,0
	syscall
	#luu dia chi file vao s0
	move $s0,$v0

	#Doc file 
	li $v0,14
	move $a0,$s0
	la $a1,str
	li $a2,1000
	syscall
#doc tung tu
	la $s0, str
	la $s2,word
	#Chon so ngau nhien
	li $t6,1
	li $t0,0
Loop:
	lb $s1,($s0)
	beq $s1,'*',bang
	bgt $t6,$t7, KetThuc
	beq $t6,$t7,doc
	j tangkitu
bang:
	addi $t6,$t6,1
	addi $t0,$t0,1
	addi $s0,$s0,1
	#addi $t0,$t0,1
	j Loop
	
doc:
	sb $s1,($s2)
	addi $s2,$s2,1
	addi $t0,$t0,1
	addi $s0,$s0,1
	j Loop
tangkitu:
	addi $s0,$s0,1
	j Loop
KetThuc:
	la $t5,'\0'
	sb $t5,($s2)

	jal _StringLength
	move $s3,$v0 ##### Do dai chuoi luu trong $s3
	addi $s3,$s3,1
	#Xuat ki tu can doan
	
	# Khoi tao cac ky tu an
	li $t7,2
	mul  $s4,$s3,$t7
	addi $t0,$0,0
	li $t1,' '
	li $t2,'_'
	#Xuat /n
	li $v0,4
	la $a0, tbxuongdong
	syscall
	
KhoiTaoWord:
	sb $t2,word2($t0)
	#xuat *
	li $v0,11
	move $a0, $t2
	syscall
	
	addi $t0,$t0,1
	sb $t1,word2($t0)
	#xuat dau cach
	li $v0,11
	move $a0,$t1
	syscall
	addi $t0,$t0,1
	bne $s4,$t0,KhoiTaoWord
	#Ket thuc \0
	la $t5,'\0'
	sb $t5,word2($t0)

	
	# Xuat tb1
	li $v0, 4
	la $a0, tb1
	syscall
	
	li $v0,1
	move $a0,$s3
	syscall
	
	# Xuat tb2
	li $v0, 4
	la $a0, tb2
	syscall
	
	addi $s1,$0,0 #### Bien kiem tra doan dung hay khong
	addi $s4,$0,0 #### Bien dem so luong ky tu da doan dung
Menu:

	#Xuat menu
	li $v0,4
	la $a0,tbmenu
	syscall
	#Nhap lua chon
	li $v0,5
	syscall
	move $s5,$v0
	beq $s5,1,Doankitu
	beq $s5,2,Doantu
	#xuat tb sai
	li $v0,4
	la $a0,tbluachonsai
	syscall
	j Menu
Doantu:
	#Xuat tbtu
	li $v0,4
	la $a0,tbtu
	syscall
	#nhap tu can doan 
	li $v0,8
	la $a0,tu
	la $a1,30
	syscall
	#kiem tra tu
	li $t0,0 # biem diem tu doan
lap1:
	lb $t6,word($t0)
	lb $t7, tu($t0)
	beq $t6,$t7,tangdem
GameThua:
	# Thong bao thua
	li $v0,4
	la $a0,gameover2
	syscall
	j Ketthuc
tangdem:
	addi $t0,$t0,1
	blt $t0,$s3,lap1
	#kiem tra tu
	lb $t7, tu($t0)
	la $t2,'\n'
	beq $t7,$t2,chienthang
	j GameThua
chienthang:
	#Xuat chien thang
	li $v0,4
	la $a0,win
	syscall
	add $t8,$t8,$s3
	addi $t9,$t9,1
	j Random
Doankitu:
	# Xuat tb3
	li $v0, 4
	la $a0, tb3
	syscall
	
	###### Nhap chu (chu luu trong $s2)
	li $v0,12
	syscall
	move $s2,$v0
	
	# Xuong dong
	li $v0, 4
	la $a0, xuongdong
	syscall
	
	# Kiem tra doan dung hay khong (dung: $s1 = 1)
	li $t0,1 # Dem so luong ky tu da doan dung
	addi $t1,$0,0
KiemTraDuDoan:
	lb $t2,word($t1)
	beq $s2,$t2,KiemTraDuDoan_Equal
	j KiemTraDuDoan_NotEqual
KiemTraDuDoan_Equal:
	li $s1,1 # Nhay den DoanDung
	li $t7,2
	mul $t4,$t1,$t7
	
	# Kiem tra ky tu da duoc doan hay chua
	lb $t6,word2($t4)
	bne $t6,'_', KiemTraDuDoan_TrungLap
	
	sb $s2,word2($t4)
	addi $s4,$s4,1
KiemTraDuDoan_NotEqual:
	addi $t1,$t1,1
	bne $t1,$s3,KiemTraDuDoan
	############
	
	beq $s1,1,DoanDung
	
	# Doan sai
	beq $s7,0,SaiLan1
	beq $s7,1,SaiLan2
	beq $s7,2,SaiLan3
	beq $s7,3,SaiLan4
	beq $s7,4,SaiLan5
	beq $s7,5,SaiLan6
	beq $s7,6,SaiLan7
	
SaiLan1:
	addi $t2,$0,1
	li $t3,'|'
SaiLan1.Loop:
	sb $t3,pic1($t2)
	addi $t2,$t2,1
	bne $t2,7,SaiLan1.Loop
	
	addi $t2,$0,0
	li $t3,'_'
	sb $t3,pic1($t2)
	sb $t3,pic2($t2)
	sb $t3,pic3($t2)
	sb $t3,pic4($t2)
	sb $t3,pic5($t2)
	sb $t3,pic6($t2)
	sb $t3,pic7($t2)
	sb $t3,pic8($t2)
	sb $t3,pic9($t2)
	sb $t3,pic10($t2)
	
	j Next
SaiLan2:	
	addi $t2,$0,1
	li $t3,'|'
	sb $t3,pic7($t2)
	addi $t2,$0,2
	li $t3,'O'
	sb $t3,pic7($t2)
	j Next
SaiLan3:	
	addi $t2,$0,3
	li $t3,'|'
	sb $t3,pic7($t2)
	j Next
SaiLan4:	
	addi $t2,$0,3
	li $t3,'/'
	sb $t3,pic6($t2)
	j Next
SaiLan5:	
	addi $t2,$0,3
	li $t3,'\\'
	sb $t3,pic8($t2)
	j Next
SaiLan6:	
	addi $t2,$0,4
	li $t3,'/'
	sb $t3,pic6($t2)
	j Next
SaiLan7:	
	addi $t2,$0,4
	li $t3,'\\'
	sb $t3,pic8($t2)
	j GameOver

	
	# Doan dung
DoanDung:
	# Xuat tb dung
	li $v0, 4
	la $a0, tbdung
	syscall
	
	li $v0 11
	move $a0,$s2
	syscall
	
	# Xuong dong
	li $v0, 4
	la $a0, xuongdong
	syscall
	jal _XuatAnh
	beq $s3,$s4,Win
	j Next2
	
KiemTraDuDoan_TrungLap:
	li $v0,4
	la $a0, trung
	syscall
	li $v0, 4
	la $a0, xuongdong
	syscall
	jal _XuatAnh
	j Next2
Next:
	addi $s7,$s7 ,1		
				
	# Xuat tb sai
	li $v0, 4
	la $a0, tbsai
	syscall
	
	li $v0 11
	move $a0,$s2
	syscall
	
	# Xuong dong
	li $v0, 4
	la $a0, xuongdong
	syscall

	jal _XuatAnh
	
Next2:	
	## Lap lai neu con luot
	
	addi $s1,$0,0
	bne $s7,7,Menu
GameOver:
	jal _XuatAnh
	# Game Over
	li $v0, 4
	la $a0, gameover
	syscall
	
	# Khoi tao lai do hoa
	addi $t1,$0,0 # Bien dem dia chi
	li $s0,' '
KhoiTaoLai:
	sb $s0,pic1($t1)
	sb $s0,pic2($t1)
	sb $s0,pic3($t1)
	sb $s0,pic4($t1)
	sb $s0,pic5($t1)
	sb $s0,pic6($t1)
	sb $s0,pic7($t1)
	sb $s0,pic8($t1)
	sb $s0,pic9($t1)
	sb $s0,pic10($t1)
	addi $t1,$t1,1
	bne $t1,7,KhoiTaoLai
	addi $s7,$0,0 # Khoi tao luôt choi lai bang 7
	j Ketthuc
Win:
	# Xuat tb thang cuoc
	li $v0, 4
	la $a0, win
	syscall
	add $t8,$t8,$s3
	addi $t9,$t9,1
	j Random
	
Exit:
	#Exit
	li $v0,10
	syscall


	# Xuat anh
_XuatAnh:
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $t1, 4($sp)
	sw $s1, 8($sp)
	
	# Xuat cac ky tu da doan duoc
	li $v0,4
	la $a0,word2
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
	
	addi $t1,$0,0 #Bien dem dia chi
_XuatAnh.Loop:
	lb $s1,pic1($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic2($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic3($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic4($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic5($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic6($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic7($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic8($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic9($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	lb $s1,pic10($t1)
	li $v0,11
	move $a0,$s1
	syscall
	
	li $v0,11
	li $a0,'\n'
	syscall
	addi $t1,$t1,1
	bne $t1,7,_XuatAnh.Loop
	
	lw $ra, ($sp)
	lw $t1, 4($sp)
	lw $s1, 8($sp)
	
	addi $sp, $sp, 12
	jr $ra
	
	# Tinh chieu dai chuoi
_StringLength:
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)

	addi $t0,$0,0
strlen_loop:
	lb	$t1,word($t0)
	beq	$t1,0,get_len
	addi	$t0,$t0,1
	j	strlen_loop
get_len:
	addi $t0,$t0,-1
	move $v0,$t0

	lw $ra, ($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	
	addi $sp, $sp, 12
	jr $ra
	
_Xuliten:
	addi $sp,$sp,-40
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	sw $t3,20($sp)
	move $s0,$a0
	
#than thu tuc
	li $t0,0
	la $t3,'\n'
lap01:
	lb $t1,($s0)
	beq $t1,$t3,thaythe
	addi $s0,$s0,1
	addi $t0,$t0,1
	j lap01
thaythe:
	la $t2,'\0'
	sb $t2,($s0)
	move $v0,$s0
#cuoi thu tuc
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	lw $t3,20($sp)
	#xoa stack
	addi $sp,$sp,40
	jr $ra
Menu1:
	#Xuat menu1
	li $v0,4
	la $a0,tbmenu1
	syscall
	#Nhap lua chon
	li $v0,5
	syscall
	move $s4,$v0
	beq $s4,1,Random
	beq $s4,2,xuatketquaxuongfile
	#xuat tb sai
	li $v0,4
	la $a0,tbluachonsai
	syscall
	j Menu1
Ketthuc:
	#xuat tbten
	li $v0,4
	la $a0,ten
	syscall
	#xuat nut gach
	li $v0,4
	la $a0,nutgach
	syscall
	#Xuat diem so
	li $v0,1
	move $a0,$t8
	syscall
	#xuat nut gach
	li $v0,4
	la $a0,nutgach
	syscall
	#Xuat luot choi
	li $v0,1
	move $a0,$t9
	syscall
	#xuat xuong dong
	li $v0,4
	la $a0,xuongdong
	syscall
	#load ketqua

	#xuat tb 10 nguoi choi cao nhat
	li $v0,4
	la $a0,tbtopdau
	syscall
	#xuat xuong dong
	li $v0,4
	la $a0,xuongdong
	syscall
	#Xuat lam menu
	li $v0,4
	la $a0,tblamMenu1
	syscall
	# xuat -----
	li $v0,4
	la $a0,tblamMenu2
	syscall
	# xuat 
	li $v0,11
	la $a0,'['
	syscall
	#dien so vao
	li $v0,1
	li $a0,1
	syscall
	#xuat ]
	li $v0,11
	la $a0,']'
	syscall
	
	#xuat khoang trang
	li $v1,0
Lap6789:
	li $v0,11
	la $a0,' '
	syscall
	addi $v1,$v1,1
	beq $v1,7,Lap6789
	#xu li 10 nguoi dau
	move $a0,$t8
	move $a1,$t9
	la $s3,ten
	jal _Mangdiemsovadau

	j Menu1

_Mangdiemsovadau:
#dau thu tuc:
	addi $sp,$sp,-100
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,16($sp)
	sw $t3,20($sp)
	sw $t4,24($sp)
	sw $t5,28($sp)
	sw $t6,32($sp)
	sw $t7,36($sp)
	sw $t8,40($sp)
	sw $t9,44($sp)
	sw $s0,48($sp)
	sw $s1,52($sp)
	sw $s2,56($sp)
	sw $s5,60($sp)
	sw $s7,64($sp)
	sw $s4,68($sp)
	sw $s6,72($sp)
	#load len diem so 
	move $s5,$a0
	#load len luot choi
	move $s7,$a1
	move $s4,$s3
#than thu tuc
	#mo file
	li $v0,13
	la $a0,tbfile1
	li $a1,0
	li $a2,0
	syscall
	#luu dia chi file vao s0
	move $s0,$v0

	#Doc file 
	li $v0,14
	move $a0,$s0
	la $a1,ss
	li $a2,1000
	syscall
	#dong file 
	li $v0,16
	move $a0,$s0
	syscall
	#xu li chuoi
	la $t3, '*'
	la $t4, '-'
	li $t0,0 # gia tri src[i]
	li $t5,0 #so luong mang trong int 
	li $t7,0 # int t=0
	la $t2,'\0'
	li $t9,0

Loop0011:
	lb $s1,ss($t0)
	bne $s1,$t3,xulivonglap  #while (src[i] != '*')
xulivonglap:
	beq $s1,$t4,chuyendoi #kiem tra voi src[i] == '-'
	j kethuc01
chuyendoi:
	addi $t0,$t0,1
	#Xu Li
	li $t1,10
	li $t8,0
vonglap:
	lb $s1, ss($t0)   
	bne $s1,$t4,loadso  #kiem tra voi src[i] != '-'
	#dua so vao int[t5]
	sh  $t8,arr($t5)
	sh $t9,stt($t5)
	#tang t5
	addi $t5,$t5,2
	addi $t7,$t7,1
	addi $t9,$t9,1
	j kehthucvonglap	
loadso:
	#dua so do vao trong int
	lb $s1,ss($t0)
	addi $s1,$s1, -48
	mul $t8, $t8, $t1
	add $t8, $t8, $s1
	addi $t0,$t0,1
	j vonglap
kehthucvonglap:
kethuc01:

	#kiemtra if (t == 1 && src[i] == '-')
	beq $t7,1,kiemtratiep
	j ketthuc02
kiemtratiep:
	beq $s1,$t4,gangiatri
	j ketthuc03
gangiatri:
	li $t7,0
ketthuc02:
ketthuc03:
	#kiemtra if (src[i] == '*')
	beq $s1,$t3,tangdem02
	j ketthuc04
tangdem02:
	addi $t0,$t0,1
ketthuc04:
	#kiemtra if (src[i] == '\0')
	lb $s1,ss($t0)
	beq $s1, $t2, ketthucham
	j tangdem03
tangdem03:
	addi $t0,$t0,1
	lb $s1,ss($t0)
	beq $s1,$t3,tangdem04
	j Loop0011
tangdem04:
	addi $t0,$t0,1
	j Loop0011
ketthucham:
	move $s6,$t0
	sb $s6, diemket
	#thay dau \0 bang dau *
	sb $t3, ss($t0)
	addi $t0,$t0,1
	la $t2,'\0'
	#Dua ten nguoi choi vao trong ss
Lap0123:
	lb $t1,($s4)
	bne $t1,$t2,tangbiendem0123
	j thoatvonglap0123
tangbiendem0123:
	sb $t1,ss($t0)
	addi $t0,$t0,1
	addi $s4,$s4,1
	j Lap0123
thoatvonglap0123:
	#them dau -
	la $t4, '-'
	sb $t4,ss($t0)
	addi $t0,$t0,1
	#noi diem so
	#add $t8,$t8,'45'
	move $t6,$s5
	li $t7,0
Loop001:
	div $t3,$t6,10
	mflo $t4
	bne $t4,0,tangdem001
	beq $t4,0,thoatlap001
tangdem001:
	addi $t7,$t7,1
	move $t6,$t4
	j Loop001
thoatlap001:

	move $s2,$s5
	li $t1,10
	li $t2,'0'
	move $t6,$t7	
loop002:
	div  $s2, $t1      
	mflo $s2
        mfhi $t4           
        add  $t4, $t4, $t2 
        sb $t4, string($t7)
	subi $t7,$t7,1 
        bne  $s2, $0, loop002
	li $t3,0
lap003:
	lb $s3,string($t3)
	sb $s3,ss($t0)
	blt $t3,$t6,tangbiendem003
	j thoat003
tangbiendem003:
	addi $t3,$t3,1
	addi $t0,$t0,1
	addi $s1,$s1,1
	j lap003
thoat003:
	#luu gach noi
	addi $t0,$t0,1
	#luu gach noi
	la $t2,'-'
	sb $t2,ss($t0)
	addi $t0,$t0,1
	#noi diem so
	move $t6,$s7
	li $t7,0
Loop0001:
	div $t3,$t6,10
	mflo $t4
	bne $t4,0,tangdem0001
	beq $t4,0,thoatlap0001
tangdem0001:
	addi $t7,$t7,1
	move $t6,$t4
	j Loop0001
thoatlap0001:

	move $s2,$s7
	li $t1,10
	li $t2,'0'
	move $t6,$t7	
loop0002:
	div  $s2, $t1      
	mflo $s2
        mfhi $t4           
        add  $t4, $t4, $t2 
        sb $t4, string($t7)
	subi $t7,$t7,1 
        bne  $s2, $0, loop0002
	li $t8,0
lap0003:
	lb $s3,string($t8)
	sb $s3,ss($t0)
	blt $t8,$t6,tangbiendem0003
	j thoat0003
tangbiendem0003:
	addi $t8,$t8,1
	addi $t0,$t0,1
	addi $s1,$s1,1
	j lap0003
thoat0003:
	#cap nhap diem vao mang
	sh $s5,arr($t5)
	sh $t9,stt($t5)
	addi $t5,$t5,2
	addi $t9,$t9,1
	#Sap xep tang dan
	#khoi tao vong lap
	li $t6,0
	li $t7,0	
	li $t2,0
	li $t3,2
	li $t0,0 #Bien dem i
	li $t1,1 #Bien dem j
	addi $s4,$t9,-1
_SapXepMangGiamDan1:
	lh $s2,arr($t2) #A[i]
	lh $t6,stt($t2)
_SapXepMangGiamDan2:
	lh $s3,arr($t3) #A[i + 1]
	lh $t7,stt($t3)
	bgt $s3,$s2,Less
	j _Ignore
Less:
	sh $s2,arr($t3)
	sh $s3,arr($t2)
	sh $t6,stt($t3)
	sh $t7,stt($t2)
	move $s2,$s3
	move $t6,$t7
_Ignore:
	addi $t3,$t3,2
	addi $t1,$t1,1
	bne $t1,$t9,_SapXepMangGiamDan2
	
	addi $t2,$t2,2
	addi $t0,$t0,1
	addi $t3,$t2,2 
	addi $t1,$t0,1 #j = i + 1
	bne $t0,$s4,_SapXepMangGiamDan1

	#XUAT RA 10 NGUOI 
	li $t9,0
	li $t3,0
	la $s2,danhsach
Lapstt:
	#Chon so ngau nhien:
	li $t6,0
	li $t0,0
	li $t5,0
	la $t8,'\0'
	li $k0,0
Loop011:
	lb $s1,ss($t5)
	#xu li
	beq $s1,'\0',Ketthuc012
	beq $s1,'*',bang011
	lh $t7,stt($t3)
	bgt $t6,$t7, KetThuc011
	beq $t6,$t7,doc011
	j tangkitu011
bang011:
	addi $t6,$t6,1
	addi $t0,$t0,1
	addi $t5,$t5,1
	#addi $t0,$t0,1
	j Loop011
	
doc011:
	beq $s1,'-',inkhoangtrang
	j tangdemk
inkhoangtrang:
Lap987:
	#in khoang trang
	li $v0,11
	la $a0,' '
	syscall
	addi $k0,$k0,1
	ble $k0,15,Lap987
	li $k0,0
tangdemk:
	sb $s1,($s2)
	beq $s1,'-',boqua
	#xuat tung ki tu
	li $v0,11
	move $a0,$s1
	syscall
boqua:
	addi $k0,$k0,1 
	addi $s2,$s2,1
	addi $t0,$t0,1
	addi $t5,$t5,1
	j Loop011
tangkitu011:
	addi $t5,$t5,1
	j Loop011
KetThuc011:
Ketthuc012:
	#xuat xuong dong
	li $v0,4
	la $a0,xuongdong
	syscall
	beq $t9,8,thaythe01234
	beq $t9,9,nhaybuoc
thaythe01234:
	#xuat [
	li $v0,11
	la $a0,'['
	syscall
	#dien so vao
	addi $k1,$t9,2
	li $v0,1
	move $a0,$k1
	syscall
	#xuat ]
	li $v0,11
	la $a0,']'
	syscall
	blt $t9,8,thaythe02345

	li $a2,6
	j nhaybuoc012
thaythe02345:
	li $a2,7
	j nhaybuoc012
nhaybuoc012:
	#xuat khoang trang
	li $v1,0
Lap789:
	li $v0,11
	la $a0,' '
	syscall
	addi $v1,$v1,1
	beq $v1,$a2,Lap789
nhaybuoc:
	addi $s2,$s2,1
	addi $t3,$t3,2
	addi $t9,$t9,1
	blt $t9,10,Lapstt
	#donfile
	li $v0,16
	la $a0, ss
	syscall
	la $t3,'\0'
	sb $t3,ss($s6)
#cuoi thu tuc:
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,16($sp)
	lw $t3,20($sp)
	lw $t4,24($sp)
	lw $t5,28($sp)
	lw $t6,32($sp)
	lw $t7,36($sp)
	lw $t8,40($sp)
	lw $t9,44($sp)
	lw $s0,48($sp)
	lw $s1,52($sp)
	lw $s2,56($sp)
	lw $s5,60($sp)
	lw $s7,64($sp)
	#xoa stack
	addi $sp,$sp,100
	jr $ra
	
xuatketquaxuongfile:
	#xuat tbten
	li $v0,4
	la $a0,ten
	syscall
	#xuat nut gach
	li $v0,4
	la $a0,nutgach
	syscall
	#Xuat diem so
	li $v0,1
	move $a0,$t8
	syscall
	#xuat nut gach
	li $v0,4
	la $a0,nutgach
	syscall
	#Xuat luot choi
	li $v0,1
	move $a0,$t9
	syscall
	#xuat xuong dong
	li $v0,4
	la $a0,xuongdong
	syscall

	#ghi xuong file

	lw $s4,diemket
	#luu gach noi
	la $t2,'*'
	sb $t2,ss($s4)
	#noi * vao chuoi
	addi $s4,$s4,1
	la $s3,ten
	la $t3,'\0'
	move $s3,$0
	
_loop001:
	lb $s5,ten($s3)
	sb $s5, ss($s4)
	beq $s5,$t3,ThayThe01
	j TangBienDem01
TangBienDem01:
	#sb $s5,($s1)
	#addi $s1,$s1,1
	addi $s3,$s3,1
	addi $s4,$s4,1
	j _loop001
ThayThe01:
	la $s6,'-'
	sb $s6,ss($s4)
#than thu tuc
	li $t0,0
	addi $s4,$s4,1
	
	#noi diem so
	#add $t8,$t8,'45'
	move $t6,$t8
	li $t7,0
Loop0111:
	div $t3,$t6,10
	mflo $t4
	bne $t4,0,tangdem0111
	beq $t4,0,thoatlap0111
tangdem0111:
	addi $t7,$t7,1
	move $t6,$t4
	j Loop0111
thoatlap0111:

	move $s2,$t8
	li $t1,10
	li $t2,'0'
	move $t6,$t7	
loop0112:
	div  $s2, $t1      
	mflo $s2
        mfhi $t4           
        add  $t4, $t4, $t2 
        sb $t4, string($t7)
	subi $t7,$t7,1 
        bne  $s2, $0, loop0112
	li $t0,0
lap0113:
	lb $s5,string($t0)
	sb $s5,ss($s4)
	blt $t0,$t6,tangbiendem0113
	j thoat0113
tangbiendem0113:
	addi $t0,$t0,1
	addi $s4,$s4,1
	j lap0113
thoat0113:
	#luu gach noi
	addi $s4,$s4,1
	#luu gach noi
	la $t2,'-'
	sb $t2,ss($s4)
	addi $s4,$s4,1
	#noi luot choi
	move $t6,$t9
	li $t7,0
Loop111:
	div $t3,$t6,10
	mflo $t4
	bne $t4,0,tangdem111
	beq $t4,0,thoatlap111
tangdem111:
	addi $t7,$t7,1
	move $t6,$t4
	j Loop111
thoatlap111:

	move $s2,$t9
	li $t1,10
	li $t2,'0'	
	move $t6,$t7
loop111:
	div  $s2, $t1      
	mflo $s2
        mfhi $t4           
        add  $t4, $t4, $t2 
        sb $t4, string($t7)
	subi $t7,$t7,1 
        bne  $s2, $0, loop111
	li $t0,0
lap111:
	lb $s5,string($t0)
	sb $s5,ss($s4)
	blt $t0,$t6,tangbiendem111
	j thoat111
tangbiendem111:
	addi $t0,$t0,1
	addi $s4,$s4,1
	j lap111
	
thoat111:
	
	#noi \0 vao chuoi
	addi $s4,$s4,1
	#luu gach noi
	la $t2,'\0'
	sb $t2,ss($s4)
	

	#them vao s4
	li $s3,0
	add $s3,$s3,$s4
	#Mo file
	li $v0,13
	la $a0,tbfile1
	li $a1,1
	li $a2,0
	syscall
	
	move $s1,$v0
	#ghi file
	li $v0, 15
	move $a0, $s1
    	la $a1, ss
    	move $a2, $s3
    	syscall
	
	#dong file
	li $v0,16
	move $a0,$s1
	syscall
	
	
