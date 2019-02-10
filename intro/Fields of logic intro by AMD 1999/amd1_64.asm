;z80
;zx-spectrum
;assembler

 



;(C)BAZon/offT -> AMDiNtRo1998!
;    /
;    >>> sPeCiAlLy FoR mAd GyE cAllEd WRECKER!

FONT    EQU     #8300
AMD_    EQU     31100
MUZ     EQU     49152
TEXT    EQU     36000

        ORG     AMD_
        INCBIN "#AMD6#.C"

        ORG     FONT
        INCBIN "FONT.C"

        ORG     TEXT
        INCBIN "4INTRO.W"

        ORG     MUZ
        INCBIN  "MAKEASI.C"

        ORG     32768
        CALL    CLSKA
        CALL    AMD_
        CALL    PRE
        JP      PODP

CLSKA   LD      HL,#4000
        LD      DE,#4001
        LD      BC,6911
        LD      (HL),L
        LDIR 
        XOR     A
        OUT     (254),A
        RET 

PRE     CALL    MUZ
        LD HL,PRER
        LD A,24
        LD (65535),A
        LD A,195
        LD (65524),A
        LD (65525),HL
        LD HL,#FE00
        LD DE,#FE01
        LD BC,256
        LD (HL),#FF
        LD A,H
        LDIR 
        DI 
        LD I,A
        IM 2
        EI 
        RET 

IMOFF   LD      A,2
        OUT     (254),A
        EI 
        HALT 
        XOR     A
        OUT     (254),A
        POP     BC
        POP     HL
        DI 
        LD A,63
        LD I,A
        IM 1
        CALL    MUZ
        CALL    CLSKA
        LD      IY,23610
        EXX 
        LD      HL,10072
        EXX 
        EI 
MMJ     LD      A,0
        RET 

PRER    PUSH HL
        PUSH DE
        PUSH BC
        PUSH AF
        PUSH IX
        PUSH IY
        CALL    MUZ+6
        POP IY
        POP IX
        POP AF
        POP BC
        POP DE
        POP HL
        EI 
        RETI 

OPSA    LD      HL,SPR
SUX     LD      A,(HL)
        CP      #FF
        RET     Z
REK1    CP      14
        JR      NZ,SEX
REK2    LD      A,22
        LD      (HL),A
SEX     INC     HL
        JR      SUX

KWADRA  LD      IX,ADRS
        LD      B,25
SD3     PUSH    BC
        LD      L,(IX+0)
        LD      H,(IX+1)
METKA2  LD      DE,SPR
        LD      B,5
SD2     PUSH    HL
        PUSH    BC
        LD      B,4
SD0     PUSH    BC
        LD      B,4
SD1     LD      A,(DE)
        LD      (HL),A
METKA1  INC     DE
        INC     HL
        DJNZ    SD1
        PUSH    DE
        LD      DE,28
        ADD     HL,DE
        POP     DE
        POP     BC
        DJNZ    SD0
        EI 
        HALT 
        POP     BC
        POP     HL
        DJNZ    SD2
        INC     IX
        INC     IX
        POP     BC
        DJNZ    SD3
        RET 

ADRS    DEFB    #49,#58,#51,#59,#D5,#58,#C9,#59,#55,#5A
        DEFB    #59,#58,#C9,#58,#D9,#59,#D1,#58,#51,#58
        DEFB    #49,#5A,#59,#59,#CD,#59,#4D,#5A,#55,#58
        DEFB    #59,#5A,#49,#59,#55,#59,#4D,#58,#CD,#58
        DEFB    #D5,#59,#D9,#58,#D1,#59,#4D,#59,#51,#5A

SPR     DEFB    14,14,14,14
        DEFB    14,14,14,14
        DEFB    14,14,14,14
        DEFB    14,14,14,14

        DEFB    14,14,14,0
        DEFB    14,14,14,0
        DEFB    14,14,14,0
        DEFB    0,0,0,0

        DEFB    14,14,0,0
        DEFB    14,14,0,0
        DEFB    0,0,0,0
        DEFB    0,0,0,0

        DEFB    14,0,0,0
        DEFB    0,0,0,0
        DEFB    0,0,0,0
        DEFB    0,0,0,0

        DEFB    0,0,0,0
        DEFB    0,0,0,0
        DEFB    0,0,0,0
        DEFB    0,0,0
SPREND  DEFB    0
        DEFB    #FF

PODP    LD      HL,TEXT
        XOR     A
        LD      (STRAN),A
PODP1   LD      A,(STRAN)
        CP      6            ;KOL-VO STRAN
        JR      Z,PODP
        INC     A
        LD      (STRAN),A
        CALL    PRINT
        PUSH    HL
        LD      A,#1B
        LD      (METKA1),A
        LD      HL,SPREND
        LD      (METKA2+1),HL
        LD      A,22
        LD      (REK1+1),A
        LD      A,14
        LD      (REK2+1),A
        CALL    OPSA
        CALL    KWADRA
        LD      BC,666 ;-)
LLL1    PUSH    BC
        EI 
        HALT 
        LD      BC,#7FFE
        IN      A,(C)
        BIT     0,A
        JP      Z,IMOFF
        LD      BC,#BFFE
        IN      A,(C)
        BIT     0,A
        POP     BC
        JR      Z,LLL
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,LLL1
LLL     LD      A,#13
        LD      (METKA1),A
        LD      HL,SPR
        LD      (METKA2+1),HL
        LD      A,14
        LD      (REK1+1),A
        LD      A,22
        LD      (REK2+1),A
        CALL    OPSA
        CALL    KWADRA
        POP     HL
        JR      PODP1

PRINT   LD D,4
        LD B,16
LM      PUSH BC
        LD E,#14
        CALL PRINT64
        POP BC
        DJNZ LM
        RET 

PRINT64 PUSH HL
        PUSH DE
        SRL E
        LD A,D
        AND #18
        OR #40
        LD H,A
        LD A,D
        AND 7
        RRCA 
        RRCA 
        RRCA 
        OR E
        LD L,A
        LD (AD_SCRN+1),HL
        POP DE
        POP HL
PRINT_X LD A,(HL)
        INC HL
        CP 10
        JR Z,PRINT13
        CP 9
        JR Z,PRINT9
        CP 13
        JR Z,PRINT_X
        CALL PR_SYMB
        JP PRINT_X
PRINT9  LD A,7
        OR E
        INC A
        LD C,A
P9_LOOP LD A,E
        CP C
        JR Z,PRINT_X
        LD A," "
        CALL PR_SYMB
        JP P9_LOOP
PRINT13 PUSH HL
        LD A,E
        CP 58
        JR Z,LABEL_9
        LD A," "
        CALL PR_SYMB
        JR $-10
LABEL_9 POP HL
        LD E,0
        INC D
        LD A,D
        CP 24
        RET C
        DEC D
        RET 
PR_SYMB PUSH DE
        EXX 
AD_SCRN LD HL,0
        LD E,A
        LD D,HIGH FONT
        POP AF
        JP NC,MASK_0F
MASK_F0 LD A,L
        INC A
        LD (AD_SCRN+1),A
        LD A,(DE)
        AND #0F
        LD C,A
        LD A,(HL)
        AND #F0
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #0F
        LD C,A
        LD A,(HL)
        AND #F0
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #0F
        LD C,A
        LD A,(HL)
        AND #F0
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #0F
        LD C,A
        LD A,(HL)
        AND #F0
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #0F
        LD C,A
        LD A,(HL)
        AND #F0
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #0F
        LD C,A
        LD A,(HL)
        AND #F0
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #0F
        LD C,A
        LD A,(HL)
        AND #F0
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #0F
        LD C,A
        LD A,(HL)
        AND #F0
        OR C
        LD (HL),A
        EXX 
        INC E
        RET 
MASK_0F LD A,(DE)
        AND #F0
        LD C,A
        LD A,(HL)
        AND #0F
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #F0
        LD C,A
        LD A,(HL)
        AND #0F
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #F0
        LD C,A
        LD A,(HL)
        AND #0F
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #F0
        LD C,A
        LD A,(HL)
        AND #0F
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #F0
        LD C,A
        LD A,(HL)
        AND #0F
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #F0
        LD C,A
        LD A,(HL)
        AND #0F
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #F0
        LD C,A
        LD A,(HL)
        AND #0F
        OR C
        LD (HL),A
        INC H
        INC D
        LD A,(DE)
        AND #F0
        LD C,A
        LD A,(HL)
        AND #0F
        OR C
        LD (HL),A
        EXX 
        INC E
        RET 

STRAN   DEFB    0
