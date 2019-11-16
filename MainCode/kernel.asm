
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp
8010002d:	b8 40 2f 10 80       	mov    $0x80102f40,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 20 72 10 80       	push   $0x80107220
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 e5 44 00 00       	call   80104540 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 27 72 10 80       	push   $0x80107227
80100097:	50                   	push   %eax
80100098:	e8 93 43 00 00       	call   80104430 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e4:	e8 77 44 00 00       	call   80104560 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 b9 45 00 00       	call   80104720 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 42 00 00       	call   80104470 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 8d 1f 00 00       	call   80102110 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 2e 72 10 80       	push   $0x8010722e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 5d 43 00 00       	call   80104510 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 47 1f 00 00       	jmp    80102110 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 3f 72 10 80       	push   $0x8010723f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 1c 43 00 00       	call   80104510 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 42 00 00       	call   801044d0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 50 43 00 00       	call   80104560 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 bf 44 00 00       	jmp    80104720 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 46 72 10 80       	push   $0x80107246
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 db 14 00 00       	call   80101760 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 cf 42 00 00       	call   80104560 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801002a7:	39 15 c4 ff 10 80    	cmp    %edx,0x8010ffc4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 c0 ff 10 80       	push   $0x8010ffc0
801002c5:	e8 66 3c 00 00       	call   80103f30 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 c4 ff 10 80    	cmp    0x8010ffc4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(proc->killed){
801002db:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002e1:	8b 40 24             	mov    0x24(%eax),%eax
801002e4:	85 c0                	test   %eax,%eax
801002e6:	74 d0                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e8:	83 ec 0c             	sub    $0xc,%esp
801002eb:	68 20 a5 10 80       	push   $0x8010a520
801002f0:	e8 2b 44 00 00       	call   80104720 <release>
        ilock(ip);
801002f5:	89 3c 24             	mov    %edi,(%esp)
801002f8:	e8 83 13 00 00       	call   80101680 <ilock>
        return -1;
801002fd:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100300:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100303:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100308:	5b                   	pop    %ebx
80100309:	5e                   	pop    %esi
8010030a:	5f                   	pop    %edi
8010030b:	5d                   	pop    %ebp
8010030c:	c3                   	ret    
8010030d:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 40 ff 10 80 	movsbl -0x7fef00c0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 ce 43 00 00       	call   80104720 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 26 13 00 00       	call   80101680 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100399:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cons.locking = 0;
8010039f:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a6:	00 00 00 
  getcallerpcs(&s, pcs);
801003a9:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003ac:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801003af:	0f b6 00             	movzbl (%eax),%eax
801003b2:	50                   	push   %eax
801003b3:	68 4d 72 10 80       	push   $0x8010724d
801003b8:	e8 a3 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bd:	58                   	pop    %eax
801003be:	ff 75 08             	pushl  0x8(%ebp)
801003c1:	e8 9a 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c6:	c7 04 24 46 77 10 80 	movl   $0x80107746,(%esp)
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d2:	5a                   	pop    %edx
801003d3:	8d 45 08             	lea    0x8(%ebp),%eax
801003d6:	59                   	pop    %ecx
801003d7:	53                   	push   %ebx
801003d8:	50                   	push   %eax
801003d9:	e8 42 42 00 00       	call   80104620 <getcallerpcs>
801003de:	83 c4 10             	add    $0x10,%esp
801003e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003e8:	83 ec 08             	sub    $0x8,%esp
801003eb:	ff 33                	pushl  (%ebx)
801003ed:	83 c3 04             	add    $0x4,%ebx
801003f0:	68 69 72 10 80       	push   $0x80107269
801003f5:	e8 66 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003fa:	83 c4 10             	add    $0x10,%esp
801003fd:	39 f3                	cmp    %esi,%ebx
801003ff:	75 e7                	jne    801003e8 <panic+0x58>
  panicked = 1; // freeze other CPU
80100401:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100408:	00 00 00 
8010040b:	eb fe                	jmp    8010040b <panic+0x7b>
8010040d:	8d 76 00             	lea    0x0(%esi),%esi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 21 5a 00 00       	call   80105e60 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 6f 59 00 00       	call   80105e60 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 63 59 00 00       	call   80105e60 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 57 59 00 00       	call   80105e60 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 f7 42 00 00       	call   80104820 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 2a 42 00 00       	call   80104770 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 6d 72 10 80       	push   $0x8010726d
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 98 72 10 80 	movzbl -0x7fef8d68(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 4c 11 00 00       	call   80101760 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 40 3f 00 00       	call   80104560 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 d4 40 00 00       	call   80104720 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 2b 10 00 00       	call   80101680 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 fc 3f 00 00       	call   80104720 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 80 72 10 80       	mov    $0x80107280,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 6b 3d 00 00       	call   80104560 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 87 72 10 80       	push   $0x80107287
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 38 3d 00 00       	call   80104560 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100856:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 93 3e 00 00       	call   80104720 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 c8 ff 10 80    	cmp    %eax,0x8010ffc8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
80100911:	68 c0 ff 10 80       	push   $0x8010ffc0
80100916:	e8 c5 37 00 00       	call   801040e0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010093d:	39 05 c4 ff 10 80    	cmp    %eax,0x8010ffc4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100964:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 24 38 00 00       	jmp    801041c0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 90 72 10 80       	push   $0x80107290
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 6b 3b 00 00       	call   80104540 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
801009d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
801009dc:	c7 05 8c 09 11 80 00 	movl   $0x80100600,0x8011098c
801009e3:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e6:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
801009ed:	02 10 80 
  cons.locking = 1;
801009f0:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f7:	00 00 00 
  picenable(IRQ_KBD);
801009fa:	e8 11 29 00 00       	call   80103310 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009ff:	58                   	pop    %eax
80100a00:	5a                   	pop    %edx
80100a01:	6a 00                	push   $0x0
80100a03:	6a 01                	push   $0x1
80100a05:	e8 d6 18 00 00       	call   801022e0 <ioapicenable>
}
80100a0a:	83 c4 10             	add    $0x10,%esp
80100a0d:	c9                   	leave  
80100a0e:	c3                   	ret    
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100a1c:	e8 1f 22 00 00       	call   80102c40 <begin_op>

  if((ip = namei(path)) == 0){
80100a21:	83 ec 0c             	sub    $0xc,%esp
80100a24:	ff 75 08             	pushl  0x8(%ebp)
80100a27:	e8 94 14 00 00       	call   80101ec0 <namei>
80100a2c:	83 c4 10             	add    $0x10,%esp
80100a2f:	85 c0                	test   %eax,%eax
80100a31:	0f 84 9d 01 00 00    	je     80100bd4 <exec+0x1c4>
    end_op();
    return -1;
  }
  ilock(ip);
80100a37:	83 ec 0c             	sub    $0xc,%esp
80100a3a:	89 c3                	mov    %eax,%ebx
80100a3c:	50                   	push   %eax
80100a3d:	e8 3e 0c 00 00       	call   80101680 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100a42:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a48:	6a 34                	push   $0x34
80100a4a:	6a 00                	push   $0x0
80100a4c:	50                   	push   %eax
80100a4d:	53                   	push   %ebx
80100a4e:	e8 ed 0e 00 00       	call   80101940 <readi>
80100a53:	83 c4 20             	add    $0x20,%esp
80100a56:	83 f8 33             	cmp    $0x33,%eax
80100a59:	77 25                	ja     80100a80 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a5b:	83 ec 0c             	sub    $0xc,%esp
80100a5e:	53                   	push   %ebx
80100a5f:	e8 8c 0e 00 00       	call   801018f0 <iunlockput>
    end_op();
80100a64:	e8 47 22 00 00       	call   80102cb0 <end_op>
80100a69:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a74:	5b                   	pop    %ebx
80100a75:	5e                   	pop    %esi
80100a76:	5f                   	pop    %edi
80100a77:	5d                   	pop    %ebp
80100a78:	c3                   	ret    
80100a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a80:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a87:	45 4c 46 
80100a8a:	75 cf                	jne    80100a5b <exec+0x4b>
  if((pgdir = setupkvm()) == 0)
80100a8c:	e8 1f 61 00 00       	call   80106bb0 <setupkvm>
80100a91:	85 c0                	test   %eax,%eax
80100a93:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a99:	74 c0                	je     80100a5b <exec+0x4b>
  sz = 0;
80100a9b:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a9d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aa4:	00 
80100aa5:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100aab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ab1:	0f 84 89 02 00 00    	je     80100d40 <exec+0x330>
80100ab7:	31 f6                	xor    %esi,%esi
80100ab9:	eb 7f                	jmp    80100b3a <exec+0x12a>
80100abb:	90                   	nop
80100abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ac7:	75 63                	jne    80100b2c <exec+0x11c>
    if(ph.memsz < ph.filesz)
80100ac9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100acf:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ad5:	0f 82 86 00 00 00    	jb     80100b61 <exec+0x151>
80100adb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae1:	72 7e                	jb     80100b61 <exec+0x151>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ae3:	83 ec 04             	sub    $0x4,%esp
80100ae6:	50                   	push   %eax
80100ae7:	57                   	push   %edi
80100ae8:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100aee:	e8 4d 63 00 00       	call   80106e40 <allocuvm>
80100af3:	83 c4 10             	add    $0x10,%esp
80100af6:	85 c0                	test   %eax,%eax
80100af8:	89 c7                	mov    %eax,%edi
80100afa:	74 65                	je     80100b61 <exec+0x151>
    if(ph.vaddr % PGSIZE != 0)
80100afc:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b02:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b07:	75 58                	jne    80100b61 <exec+0x151>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b09:	83 ec 0c             	sub    $0xc,%esp
80100b0c:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b12:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b18:	53                   	push   %ebx
80100b19:	50                   	push   %eax
80100b1a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b20:	e8 5b 62 00 00       	call   80106d80 <loaduvm>
80100b25:	83 c4 20             	add    $0x20,%esp
80100b28:	85 c0                	test   %eax,%eax
80100b2a:	78 35                	js     80100b61 <exec+0x151>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b2c:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b33:	83 c6 01             	add    $0x1,%esi
80100b36:	39 f0                	cmp    %esi,%eax
80100b38:	7e 46                	jle    80100b80 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b3a:	89 f0                	mov    %esi,%eax
80100b3c:	6a 20                	push   $0x20
80100b3e:	c1 e0 05             	shl    $0x5,%eax
80100b41:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100b47:	50                   	push   %eax
80100b48:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b4e:	50                   	push   %eax
80100b4f:	53                   	push   %ebx
80100b50:	e8 eb 0d 00 00       	call   80101940 <readi>
80100b55:	83 c4 10             	add    $0x10,%esp
80100b58:	83 f8 20             	cmp    $0x20,%eax
80100b5b:	0f 84 5f ff ff ff    	je     80100ac0 <exec+0xb0>
    freevm(pgdir);
80100b61:	83 ec 0c             	sub    $0xc,%esp
80100b64:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b6a:	e8 31 64 00 00       	call   80106fa0 <freevm>
80100b6f:	83 c4 10             	add    $0x10,%esp
80100b72:	e9 e4 fe ff ff       	jmp    80100a5b <exec+0x4b>
80100b77:	89 f6                	mov    %esi,%esi
80100b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80100b80:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b86:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8c:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b92:	83 ec 0c             	sub    $0xc,%esp
80100b95:	53                   	push   %ebx
80100b96:	e8 55 0d 00 00       	call   801018f0 <iunlockput>
  end_op();
80100b9b:	e8 10 21 00 00       	call   80102cb0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ba0:	83 c4 0c             	add    $0xc,%esp
80100ba3:	56                   	push   %esi
80100ba4:	57                   	push   %edi
80100ba5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bab:	e8 90 62 00 00       	call   80106e40 <allocuvm>
80100bb0:	83 c4 10             	add    $0x10,%esp
80100bb3:	85 c0                	test   %eax,%eax
80100bb5:	89 c6                	mov    %eax,%esi
80100bb7:	75 2a                	jne    80100be3 <exec+0x1d3>
    freevm(pgdir);
80100bb9:	83 ec 0c             	sub    $0xc,%esp
80100bbc:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bc2:	e8 d9 63 00 00       	call   80106fa0 <freevm>
80100bc7:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bcf:	e9 9d fe ff ff       	jmp    80100a71 <exec+0x61>
    end_op();
80100bd4:	e8 d7 20 00 00       	call   80102cb0 <end_op>
    return -1;
80100bd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bde:	e9 8e fe ff ff       	jmp    80100a71 <exec+0x61>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100be3:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100be9:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bec:	31 ff                	xor    %edi,%edi
80100bee:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf0:	50                   	push   %eax
80100bf1:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bf7:	e8 24 64 00 00       	call   80107020 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bff:	83 c4 10             	add    $0x10,%esp
80100c02:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c08:	8b 00                	mov    (%eax),%eax
80100c0a:	85 c0                	test   %eax,%eax
80100c0c:	74 6f                	je     80100c7d <exec+0x26d>
80100c0e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c14:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c1a:	eb 09                	jmp    80100c25 <exec+0x215>
80100c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c20:	83 ff 20             	cmp    $0x20,%edi
80100c23:	74 94                	je     80100bb9 <exec+0x1a9>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c25:	83 ec 0c             	sub    $0xc,%esp
80100c28:	50                   	push   %eax
80100c29:	e8 82 3d 00 00       	call   801049b0 <strlen>
80100c2e:	f7 d0                	not    %eax
80100c30:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c32:	58                   	pop    %eax
80100c33:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c36:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c39:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c3c:	e8 6f 3d 00 00       	call   801049b0 <strlen>
80100c41:	83 c0 01             	add    $0x1,%eax
80100c44:	50                   	push   %eax
80100c45:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c48:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4b:	53                   	push   %ebx
80100c4c:	56                   	push   %esi
80100c4d:	e8 1e 65 00 00       	call   80107170 <copyout>
80100c52:	83 c4 20             	add    $0x20,%esp
80100c55:	85 c0                	test   %eax,%eax
80100c57:	0f 88 5c ff ff ff    	js     80100bb9 <exec+0x1a9>
  for(argc = 0; argv[argc]; argc++) {
80100c5d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c60:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c67:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c6a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c70:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c73:	85 c0                	test   %eax,%eax
80100c75:	75 a9                	jne    80100c20 <exec+0x210>
80100c77:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c7d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c84:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c86:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c8d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100c91:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c98:	ff ff ff 
  ustack[1] = argc;
80100c9b:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100ca3:	83 c0 0c             	add    $0xc,%eax
80100ca6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ca8:	50                   	push   %eax
80100ca9:	52                   	push   %edx
80100caa:	53                   	push   %ebx
80100cab:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb7:	e8 b4 64 00 00       	call   80107170 <copyout>
80100cbc:	83 c4 10             	add    $0x10,%esp
80100cbf:	85 c0                	test   %eax,%eax
80100cc1:	0f 88 f2 fe ff ff    	js     80100bb9 <exec+0x1a9>
  for(last=s=path; *s; s++)
80100cc7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cca:	8b 55 08             	mov    0x8(%ebp),%edx
80100ccd:	0f b6 00             	movzbl (%eax),%eax
80100cd0:	84 c0                	test   %al,%al
80100cd2:	74 11                	je     80100ce5 <exec+0x2d5>
80100cd4:	89 d1                	mov    %edx,%ecx
80100cd6:	83 c1 01             	add    $0x1,%ecx
80100cd9:	3c 2f                	cmp    $0x2f,%al
80100cdb:	0f b6 01             	movzbl (%ecx),%eax
80100cde:	0f 44 d1             	cmove  %ecx,%edx
80100ce1:	84 c0                	test   %al,%al
80100ce3:	75 f1                	jne    80100cd6 <exec+0x2c6>
  safestrcpy(proc->name, last, sizeof(proc->name));
80100ce5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ceb:	83 ec 04             	sub    $0x4,%esp
80100cee:	6a 10                	push   $0x10
80100cf0:	52                   	push   %edx
80100cf1:	83 c0 6c             	add    $0x6c,%eax
80100cf4:	50                   	push   %eax
80100cf5:	e8 76 3c 00 00       	call   80104970 <safestrcpy>
  oldpgdir = proc->pgdir;
80100cfa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100d00:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
  oldpgdir = proc->pgdir;
80100d06:	8b 78 04             	mov    0x4(%eax),%edi
  proc->sz = sz;
80100d09:	89 30                	mov    %esi,(%eax)
  proc->pgdir = pgdir;
80100d0b:	89 50 04             	mov    %edx,0x4(%eax)
  proc->tf->eip = elf.entry;  // main
80100d0e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d14:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100d1a:	8b 50 18             	mov    0x18(%eax),%edx
80100d1d:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100d20:	8b 50 18             	mov    0x18(%eax),%edx
80100d23:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(proc);
80100d26:	89 04 24             	mov    %eax,(%esp)
80100d29:	e8 32 5f 00 00       	call   80106c60 <switchuvm>
  freevm(oldpgdir);
80100d2e:	89 3c 24             	mov    %edi,(%esp)
80100d31:	e8 6a 62 00 00       	call   80106fa0 <freevm>
  return 0;
80100d36:	83 c4 10             	add    $0x10,%esp
80100d39:	31 c0                	xor    %eax,%eax
80100d3b:	e9 31 fd ff ff       	jmp    80100a71 <exec+0x61>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d40:	be 00 20 00 00       	mov    $0x2000,%esi
80100d45:	e9 48 fe ff ff       	jmp    80100b92 <exec+0x182>
80100d4a:	66 90                	xchg   %ax,%ax
80100d4c:	66 90                	xchg   %ax,%ax
80100d4e:	66 90                	xchg   %ax,%ax

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d56:	68 a9 72 10 80       	push   $0x801072a9
80100d5b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d60:	e8 db 37 00 00       	call   80104540 <initlock>
}
80100d65:	83 c4 10             	add    $0x10,%esp
80100d68:	c9                   	leave  
80100d69:	c3                   	ret    
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb 14 00 11 80       	mov    $0x80110014,%ebx
{
80100d79:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d7c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d81:	e8 da 37 00 00       	call   80104560 <acquire>
80100d86:	83 c4 10             	add    $0x10,%esp
80100d89:	eb 10                	jmp    80100d9b <filealloc+0x2b>
80100d8b:	90                   	nop
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100d99:	73 25                	jae    80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100da2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100da5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dac:	68 e0 ff 10 80       	push   $0x8010ffe0
80100db1:	e8 6a 39 00 00       	call   80104720 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100db6:	89 d8                	mov    %ebx,%eax
      return f;
80100db8:	83 c4 10             	add    $0x10,%esp
}
80100dbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dbe:	c9                   	leave  
80100dbf:	c3                   	ret    
  release(&ftable.lock);
80100dc0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dc3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dc5:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dca:	e8 51 39 00 00       	call   80104720 <release>
}
80100dcf:	89 d8                	mov    %ebx,%eax
  return 0;
80100dd1:	83 c4 10             	add    $0x10,%esp
}
80100dd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dd7:	c9                   	leave  
80100dd8:	c3                   	ret    
80100dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 10             	sub    $0x10,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	68 e0 ff 10 80       	push   $0x8010ffe0
80100def:	e8 6c 37 00 00       	call   80104560 <acquire>
  if(f->ref < 1)
80100df4:	8b 43 04             	mov    0x4(%ebx),%eax
80100df7:	83 c4 10             	add    $0x10,%esp
80100dfa:	85 c0                	test   %eax,%eax
80100dfc:	7e 1a                	jle    80100e18 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dfe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e01:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e04:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e07:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e0c:	e8 0f 39 00 00       	call   80104720 <release>
  return f;
}
80100e11:	89 d8                	mov    %ebx,%eax
80100e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    
    panic("filedup");
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	68 b0 72 10 80       	push   $0x801072b0
80100e20:	e8 6b f5 ff ff       	call   80100390 <panic>
80100e25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 28             	sub    $0x28,%esp
80100e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e41:	e8 1a 37 00 00       	call   80104560 <acquire>
  if(f->ref < 1)
80100e46:	8b 43 04             	mov    0x4(%ebx),%eax
80100e49:	83 c4 10             	add    $0x10,%esp
80100e4c:	85 c0                	test   %eax,%eax
80100e4e:	0f 8e 9b 00 00 00    	jle    80100eef <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e54:	83 e8 01             	sub    $0x1,%eax
80100e57:	85 c0                	test   %eax,%eax
80100e59:	89 43 04             	mov    %eax,0x4(%ebx)
80100e5c:	74 1a                	je     80100e78 <fileclose+0x48>
    release(&ftable.lock);
80100e5e:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e68:	5b                   	pop    %ebx
80100e69:	5e                   	pop    %esi
80100e6a:	5f                   	pop    %edi
80100e6b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e6c:	e9 af 38 00 00       	jmp    80104720 <release>
80100e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e78:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e7c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e7e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e81:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e84:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e8a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e8d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100e90:	68 e0 ff 10 80       	push   $0x8010ffe0
  ff = *f;
80100e95:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e98:	e8 83 38 00 00       	call   80104720 <release>
  if(ff.type == FD_PIPE)
80100e9d:	83 c4 10             	add    $0x10,%esp
80100ea0:	83 ff 01             	cmp    $0x1,%edi
80100ea3:	74 13                	je     80100eb8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100ea5:	83 ff 02             	cmp    $0x2,%edi
80100ea8:	74 26                	je     80100ed0 <fileclose+0xa0>
}
80100eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ead:	5b                   	pop    %ebx
80100eae:	5e                   	pop    %esi
80100eaf:	5f                   	pop    %edi
80100eb0:	5d                   	pop    %ebp
80100eb1:	c3                   	ret    
80100eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100eb8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ebc:	83 ec 08             	sub    $0x8,%esp
80100ebf:	53                   	push   %ebx
80100ec0:	56                   	push   %esi
80100ec1:	e8 2a 26 00 00       	call   801034f0 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ed0:	e8 6b 1d 00 00       	call   80102c40 <begin_op>
    iput(ff.ip);
80100ed5:	83 ec 0c             	sub    $0xc,%esp
80100ed8:	ff 75 e0             	pushl  -0x20(%ebp)
80100edb:	e8 d0 08 00 00       	call   801017b0 <iput>
    end_op();
80100ee0:	83 c4 10             	add    $0x10,%esp
}
80100ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ee6:	5b                   	pop    %ebx
80100ee7:	5e                   	pop    %esi
80100ee8:	5f                   	pop    %edi
80100ee9:	5d                   	pop    %ebp
    end_op();
80100eea:	e9 c1 1d 00 00       	jmp    80102cb0 <end_op>
    panic("fileclose");
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 b8 72 10 80       	push   $0x801072b8
80100ef7:	e8 94 f4 ff ff       	call   80100390 <panic>
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f00 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	53                   	push   %ebx
80100f04:	83 ec 04             	sub    $0x4,%esp
80100f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f0d:	75 31                	jne    80100f40 <filestat+0x40>
    ilock(f->ip);
80100f0f:	83 ec 0c             	sub    $0xc,%esp
80100f12:	ff 73 10             	pushl  0x10(%ebx)
80100f15:	e8 66 07 00 00       	call   80101680 <ilock>
    stati(f->ip, st);
80100f1a:	58                   	pop    %eax
80100f1b:	5a                   	pop    %edx
80100f1c:	ff 75 0c             	pushl  0xc(%ebp)
80100f1f:	ff 73 10             	pushl  0x10(%ebx)
80100f22:	e8 e9 09 00 00       	call   80101910 <stati>
    iunlock(f->ip);
80100f27:	59                   	pop    %ecx
80100f28:	ff 73 10             	pushl  0x10(%ebx)
80100f2b:	e8 30 08 00 00       	call   80101760 <iunlock>
    return 0;
80100f30:	83 c4 10             	add    $0x10,%esp
80100f33:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f45:	eb ee                	jmp    80100f35 <filestat+0x35>
80100f47:	89 f6                	mov    %esi,%esi
80100f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	57                   	push   %edi
80100f54:	56                   	push   %esi
80100f55:	53                   	push   %ebx
80100f56:	83 ec 0c             	sub    $0xc,%esp
80100f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f5f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f66:	74 60                	je     80100fc8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f68:	8b 03                	mov    (%ebx),%eax
80100f6a:	83 f8 01             	cmp    $0x1,%eax
80100f6d:	74 41                	je     80100fb0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f6f:	83 f8 02             	cmp    $0x2,%eax
80100f72:	75 5b                	jne    80100fcf <fileread+0x7f>
    ilock(f->ip);
80100f74:	83 ec 0c             	sub    $0xc,%esp
80100f77:	ff 73 10             	pushl  0x10(%ebx)
80100f7a:	e8 01 07 00 00       	call   80101680 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f7f:	57                   	push   %edi
80100f80:	ff 73 14             	pushl  0x14(%ebx)
80100f83:	56                   	push   %esi
80100f84:	ff 73 10             	pushl  0x10(%ebx)
80100f87:	e8 b4 09 00 00       	call   80101940 <readi>
80100f8c:	83 c4 20             	add    $0x20,%esp
80100f8f:	85 c0                	test   %eax,%eax
80100f91:	89 c6                	mov    %eax,%esi
80100f93:	7e 03                	jle    80100f98 <fileread+0x48>
      f->off += r;
80100f95:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f98:	83 ec 0c             	sub    $0xc,%esp
80100f9b:	ff 73 10             	pushl  0x10(%ebx)
80100f9e:	e8 bd 07 00 00       	call   80101760 <iunlock>
    return r;
80100fa3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa9:	89 f0                	mov    %esi,%eax
80100fab:	5b                   	pop    %ebx
80100fac:	5e                   	pop    %esi
80100fad:	5f                   	pop    %edi
80100fae:	5d                   	pop    %ebp
80100faf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fb0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fb3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	5b                   	pop    %ebx
80100fba:	5e                   	pop    %esi
80100fbb:	5f                   	pop    %edi
80100fbc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fbd:	e9 fe 26 00 00       	jmp    801036c0 <piperead>
80100fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fc8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fcd:	eb d7                	jmp    80100fa6 <fileread+0x56>
  panic("fileread");
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	68 c2 72 10 80       	push   $0x801072c2
80100fd7:	e8 b4 f3 ff ff       	call   80100390 <panic>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 1c             	sub    $0x1c,%esp
80100fe9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fec:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fef:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80100ff3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff6:	8b 45 10             	mov    0x10(%ebp),%eax
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80100ffc:	0f 84 aa 00 00 00    	je     801010ac <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101002:	8b 06                	mov    (%esi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c3 00 00 00    	je     801010d0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d9 00 00 00    	jne    801010ef <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101019:	31 ff                	xor    %edi,%edi
    while(i < n){
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 34                	jg     80101053 <filewrite+0x73>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101028:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010102b:	83 ec 0c             	sub    $0xc,%esp
8010102e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101031:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101034:	e8 27 07 00 00       	call   80101760 <iunlock>
      end_op();
80101039:	e8 72 1c 00 00       	call   80102cb0 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101041:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101044:	39 c3                	cmp    %eax,%ebx
80101046:	0f 85 96 00 00 00    	jne    801010e2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010104c:	01 df                	add    %ebx,%edi
    while(i < n){
8010104e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101051:	7e 6d                	jle    801010c0 <filewrite+0xe0>
      int n1 = n - i;
80101053:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101056:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010105b:	29 fb                	sub    %edi,%ebx
8010105d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101063:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101066:	e8 d5 1b 00 00       	call   80102c40 <begin_op>
      ilock(f->ip);
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	ff 76 10             	pushl  0x10(%esi)
80101071:	e8 0a 06 00 00       	call   80101680 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101076:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101079:	53                   	push   %ebx
8010107a:	ff 76 14             	pushl  0x14(%esi)
8010107d:	01 f8                	add    %edi,%eax
8010107f:	50                   	push   %eax
80101080:	ff 76 10             	pushl  0x10(%esi)
80101083:	e8 b8 09 00 00       	call   80101a40 <writei>
80101088:	83 c4 20             	add    $0x20,%esp
8010108b:	85 c0                	test   %eax,%eax
8010108d:	7f 99                	jg     80101028 <filewrite+0x48>
      iunlock(f->ip);
8010108f:	83 ec 0c             	sub    $0xc,%esp
80101092:	ff 76 10             	pushl  0x10(%esi)
80101095:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101098:	e8 c3 06 00 00       	call   80101760 <iunlock>
      end_op();
8010109d:	e8 0e 1c 00 00       	call   80102cb0 <end_op>
      if(r < 0)
801010a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a5:	83 c4 10             	add    $0x10,%esp
801010a8:	85 c0                	test   %eax,%eax
801010aa:	74 98                	je     80101044 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010af:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010b4:	89 f8                	mov    %edi,%eax
801010b6:	5b                   	pop    %ebx
801010b7:	5e                   	pop    %esi
801010b8:	5f                   	pop    %edi
801010b9:	5d                   	pop    %ebp
801010ba:	c3                   	ret    
801010bb:	90                   	nop
801010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010c0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010c3:	75 e7                	jne    801010ac <filewrite+0xcc>
}
801010c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c8:	89 f8                	mov    %edi,%eax
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
801010cf:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010d0:	8b 46 0c             	mov    0xc(%esi),%eax
801010d3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d9:	5b                   	pop    %ebx
801010da:	5e                   	pop    %esi
801010db:	5f                   	pop    %edi
801010dc:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010dd:	e9 ae 24 00 00       	jmp    80103590 <pipewrite>
        panic("short filewrite");
801010e2:	83 ec 0c             	sub    $0xc,%esp
801010e5:	68 cb 72 10 80       	push   $0x801072cb
801010ea:	e8 a1 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	68 d1 72 10 80       	push   $0x801072d1
801010f7:	e8 94 f2 ff ff       	call   80100390 <panic>
801010fc:	66 90                	xchg   %ax,%ax
801010fe:	66 90                	xchg   %ax,%ax

80101100 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101109:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
{
8010110f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101112:	85 c9                	test   %ecx,%ecx
80101114:	0f 84 87 00 00 00    	je     801011a1 <balloc+0xa1>
8010111a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101121:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101124:	83 ec 08             	sub    $0x8,%esp
80101127:	89 f0                	mov    %esi,%eax
80101129:	c1 f8 0c             	sar    $0xc,%eax
8010112c:	03 05 f8 09 11 80    	add    0x801109f8,%eax
80101132:	50                   	push   %eax
80101133:	ff 75 d8             	pushl  -0x28(%ebp)
80101136:	e8 95 ef ff ff       	call   801000d0 <bread>
8010113b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010113e:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101143:	83 c4 10             	add    $0x10,%esp
80101146:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101149:	31 c0                	xor    %eax,%eax
8010114b:	eb 2f                	jmp    8010117c <balloc+0x7c>
8010114d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101150:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101152:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101155:	bb 01 00 00 00       	mov    $0x1,%ebx
8010115a:	83 e1 07             	and    $0x7,%ecx
8010115d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010115f:	89 c1                	mov    %eax,%ecx
80101161:	c1 f9 03             	sar    $0x3,%ecx
80101164:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101169:	85 df                	test   %ebx,%edi
8010116b:	89 fa                	mov    %edi,%edx
8010116d:	74 41                	je     801011b0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010116f:	83 c0 01             	add    $0x1,%eax
80101172:	83 c6 01             	add    $0x1,%esi
80101175:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010117a:	74 05                	je     80101181 <balloc+0x81>
8010117c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010117f:	77 cf                	ja     80101150 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101181:	83 ec 0c             	sub    $0xc,%esp
80101184:	ff 75 e4             	pushl  -0x1c(%ebp)
80101187:	e8 54 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010118c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101193:	83 c4 10             	add    $0x10,%esp
80101196:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101199:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010119f:	77 80                	ja     80101121 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011a1:	83 ec 0c             	sub    $0xc,%esp
801011a4:	68 db 72 10 80       	push   $0x801072db
801011a9:	e8 e2 f1 ff ff       	call   80100390 <panic>
801011ae:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011b0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011b3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011b6:	09 da                	or     %ebx,%edx
801011b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011bc:	57                   	push   %edi
801011bd:	e8 4e 1c 00 00       	call   80102e10 <log_write>
        brelse(bp);
801011c2:	89 3c 24             	mov    %edi,(%esp)
801011c5:	e8 16 f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011ca:	58                   	pop    %eax
801011cb:	5a                   	pop    %edx
801011cc:	56                   	push   %esi
801011cd:	ff 75 d8             	pushl  -0x28(%ebp)
801011d0:	e8 fb ee ff ff       	call   801000d0 <bread>
801011d5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011da:	83 c4 0c             	add    $0xc,%esp
801011dd:	68 00 02 00 00       	push   $0x200
801011e2:	6a 00                	push   $0x0
801011e4:	50                   	push   %eax
801011e5:	e8 86 35 00 00       	call   80104770 <memset>
  log_write(bp);
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 1e 1c 00 00       	call   80102e10 <log_write>
  brelse(bp);
801011f2:	89 1c 24             	mov    %ebx,(%esp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
}
801011fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fd:	89 f0                	mov    %esi,%eax
801011ff:	5b                   	pop    %ebx
80101200:	5e                   	pop    %esi
80101201:	5f                   	pop    %edi
80101202:	5d                   	pop    %ebp
80101203:	c3                   	ret    
80101204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010120a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101210 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101218:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010121a:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
8010121f:	83 ec 28             	sub    $0x28,%esp
80101222:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101225:	68 00 0a 11 80       	push   $0x80110a00
8010122a:	e8 31 33 00 00       	call   80104560 <acquire>
8010122f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101232:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101235:	eb 17                	jmp    8010124e <iget+0x3e>
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101240:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101246:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
8010124c:	73 22                	jae    80101270 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010124e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101251:	85 c9                	test   %ecx,%ecx
80101253:	7e 04                	jle    80101259 <iget+0x49>
80101255:	39 3b                	cmp    %edi,(%ebx)
80101257:	74 4f                	je     801012a8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101259:	85 f6                	test   %esi,%esi
8010125b:	75 e3                	jne    80101240 <iget+0x30>
8010125d:	85 c9                	test   %ecx,%ecx
8010125f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101262:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101268:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
8010126e:	72 de                	jb     8010124e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101270:	85 f6                	test   %esi,%esi
80101272:	74 5b                	je     801012cf <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
80101274:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101277:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101279:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010127c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101283:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010128a:	68 00 0a 11 80       	push   $0x80110a00
8010128f:	e8 8c 34 00 00       	call   80104720 <release>

  return ip;
80101294:	83 c4 10             	add    $0x10,%esp
}
80101297:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010129a:	89 f0                	mov    %esi,%eax
8010129c:	5b                   	pop    %ebx
8010129d:	5e                   	pop    %esi
8010129e:	5f                   	pop    %edi
8010129f:	5d                   	pop    %ebp
801012a0:	c3                   	ret    
801012a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012a8:	39 53 04             	cmp    %edx,0x4(%ebx)
801012ab:	75 ac                	jne    80101259 <iget+0x49>
      release(&icache.lock);
801012ad:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012b0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012b3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012b5:	68 00 0a 11 80       	push   $0x80110a00
      ip->ref++;
801012ba:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012bd:	e8 5e 34 00 00       	call   80104720 <release>
      return ip;
801012c2:	83 c4 10             	add    $0x10,%esp
}
801012c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012c8:	89 f0                	mov    %esi,%eax
801012ca:	5b                   	pop    %ebx
801012cb:	5e                   	pop    %esi
801012cc:	5f                   	pop    %edi
801012cd:	5d                   	pop    %ebp
801012ce:	c3                   	ret    
    panic("iget: no inodes");
801012cf:	83 ec 0c             	sub    $0xc,%esp
801012d2:	68 f1 72 10 80       	push   $0x801072f1
801012d7:	e8 b4 f0 ff ff       	call   80100390 <panic>
801012dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c6                	mov    %eax,%esi
801012e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012eb:	83 fa 0b             	cmp    $0xb,%edx
801012ee:	77 18                	ja     80101308 <bmap+0x28>
801012f0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801012f3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801012f6:	85 db                	test   %ebx,%ebx
801012f8:	74 76                	je     80101370 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012fd:	89 d8                	mov    %ebx,%eax
801012ff:	5b                   	pop    %ebx
80101300:	5e                   	pop    %esi
80101301:	5f                   	pop    %edi
80101302:	5d                   	pop    %ebp
80101303:	c3                   	ret    
80101304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101308:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010130b:	83 fb 7f             	cmp    $0x7f,%ebx
8010130e:	0f 87 90 00 00 00    	ja     801013a4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101314:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010131a:	8b 00                	mov    (%eax),%eax
8010131c:	85 d2                	test   %edx,%edx
8010131e:	74 70                	je     80101390 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101320:	83 ec 08             	sub    $0x8,%esp
80101323:	52                   	push   %edx
80101324:	50                   	push   %eax
80101325:	e8 a6 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010132a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010132e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101331:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101333:	8b 1a                	mov    (%edx),%ebx
80101335:	85 db                	test   %ebx,%ebx
80101337:	75 1d                	jne    80101356 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101339:	8b 06                	mov    (%esi),%eax
8010133b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010133e:	e8 bd fd ff ff       	call   80101100 <balloc>
80101343:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101346:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101349:	89 c3                	mov    %eax,%ebx
8010134b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010134d:	57                   	push   %edi
8010134e:	e8 bd 1a 00 00       	call   80102e10 <log_write>
80101353:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101356:	83 ec 0c             	sub    $0xc,%esp
80101359:	57                   	push   %edi
8010135a:	e8 81 ee ff ff       	call   801001e0 <brelse>
8010135f:	83 c4 10             	add    $0x10,%esp
}
80101362:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101365:	89 d8                	mov    %ebx,%eax
80101367:	5b                   	pop    %ebx
80101368:	5e                   	pop    %esi
80101369:	5f                   	pop    %edi
8010136a:	5d                   	pop    %ebp
8010136b:	c3                   	ret    
8010136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101370:	8b 00                	mov    (%eax),%eax
80101372:	e8 89 fd ff ff       	call   80101100 <balloc>
80101377:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010137d:	89 c3                	mov    %eax,%ebx
}
8010137f:	89 d8                	mov    %ebx,%eax
80101381:	5b                   	pop    %ebx
80101382:	5e                   	pop    %esi
80101383:	5f                   	pop    %edi
80101384:	5d                   	pop    %ebp
80101385:	c3                   	ret    
80101386:	8d 76 00             	lea    0x0(%esi),%esi
80101389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101390:	e8 6b fd ff ff       	call   80101100 <balloc>
80101395:	89 c2                	mov    %eax,%edx
80101397:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010139d:	8b 06                	mov    (%esi),%eax
8010139f:	e9 7c ff ff ff       	jmp    80101320 <bmap+0x40>
  panic("bmap: out of range");
801013a4:	83 ec 0c             	sub    $0xc,%esp
801013a7:	68 01 73 10 80       	push   $0x80107301
801013ac:	e8 df ef ff ff       	call   80100390 <panic>
801013b1:	eb 0d                	jmp    801013c0 <readsb>
801013b3:	90                   	nop
801013b4:	90                   	nop
801013b5:	90                   	nop
801013b6:	90                   	nop
801013b7:	90                   	nop
801013b8:	90                   	nop
801013b9:	90                   	nop
801013ba:	90                   	nop
801013bb:	90                   	nop
801013bc:	90                   	nop
801013bd:	90                   	nop
801013be:	90                   	nop
801013bf:	90                   	nop

801013c0 <readsb>:
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	56                   	push   %esi
801013c4:	53                   	push   %ebx
801013c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013c8:	83 ec 08             	sub    $0x8,%esp
801013cb:	6a 01                	push   $0x1
801013cd:	ff 75 08             	pushl  0x8(%ebp)
801013d0:	e8 fb ec ff ff       	call   801000d0 <bread>
801013d5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013da:	83 c4 0c             	add    $0xc,%esp
801013dd:	6a 1c                	push   $0x1c
801013df:	50                   	push   %eax
801013e0:	56                   	push   %esi
801013e1:	e8 3a 34 00 00       	call   80104820 <memmove>
  brelse(bp);
801013e6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013e9:	83 c4 10             	add    $0x10,%esp
}
801013ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013ef:	5b                   	pop    %ebx
801013f0:	5e                   	pop    %esi
801013f1:	5d                   	pop    %ebp
  brelse(bp);
801013f2:	e9 e9 ed ff ff       	jmp    801001e0 <brelse>
801013f7:	89 f6                	mov    %esi,%esi
801013f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101400 <bfree>:
{
80101400:	55                   	push   %ebp
80101401:	89 e5                	mov    %esp,%ebp
80101403:	56                   	push   %esi
80101404:	53                   	push   %ebx
80101405:	89 d3                	mov    %edx,%ebx
80101407:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101409:	83 ec 08             	sub    $0x8,%esp
8010140c:	68 e0 09 11 80       	push   $0x801109e0
80101411:	50                   	push   %eax
80101412:	e8 a9 ff ff ff       	call   801013c0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101417:	58                   	pop    %eax
80101418:	5a                   	pop    %edx
80101419:	89 da                	mov    %ebx,%edx
8010141b:	c1 ea 0c             	shr    $0xc,%edx
8010141e:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101424:	52                   	push   %edx
80101425:	56                   	push   %esi
80101426:	e8 a5 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010142b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010142d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101430:	ba 01 00 00 00       	mov    $0x1,%edx
80101435:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101438:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010143e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101441:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101443:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101448:	85 d1                	test   %edx,%ecx
8010144a:	74 25                	je     80101471 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010144c:	f7 d2                	not    %edx
8010144e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101450:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101453:	21 ca                	and    %ecx,%edx
80101455:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101459:	56                   	push   %esi
8010145a:	e8 b1 19 00 00       	call   80102e10 <log_write>
  brelse(bp);
8010145f:	89 34 24             	mov    %esi,(%esp)
80101462:	e8 79 ed ff ff       	call   801001e0 <brelse>
}
80101467:	83 c4 10             	add    $0x10,%esp
8010146a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010146d:	5b                   	pop    %ebx
8010146e:	5e                   	pop    %esi
8010146f:	5d                   	pop    %ebp
80101470:	c3                   	ret    
    panic("freeing free block");
80101471:	83 ec 0c             	sub    $0xc,%esp
80101474:	68 14 73 10 80       	push   $0x80107314
80101479:	e8 12 ef ff ff       	call   80100390 <panic>
8010147e:	66 90                	xchg   %ax,%ax

80101480 <iinit>:
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	53                   	push   %ebx
80101484:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101489:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010148c:	68 27 73 10 80       	push   $0x80107327
80101491:	68 00 0a 11 80       	push   $0x80110a00
80101496:	e8 a5 30 00 00       	call   80104540 <initlock>
8010149b:	83 c4 10             	add    $0x10,%esp
8010149e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014a0:	83 ec 08             	sub    $0x8,%esp
801014a3:	68 2e 73 10 80       	push   $0x8010732e
801014a8:	53                   	push   %ebx
801014a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014af:	e8 7c 2f 00 00       	call   80104430 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014b4:	83 c4 10             	add    $0x10,%esp
801014b7:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
801014bd:	75 e1                	jne    801014a0 <iinit+0x20>
  readsb(dev, &sb);
801014bf:	83 ec 08             	sub    $0x8,%esp
801014c2:	68 e0 09 11 80       	push   $0x801109e0
801014c7:	ff 75 08             	pushl  0x8(%ebp)
801014ca:	e8 f1 fe ff ff       	call   801013c0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014cf:	ff 35 f8 09 11 80    	pushl  0x801109f8
801014d5:	ff 35 f4 09 11 80    	pushl  0x801109f4
801014db:	ff 35 f0 09 11 80    	pushl  0x801109f0
801014e1:	ff 35 ec 09 11 80    	pushl  0x801109ec
801014e7:	ff 35 e8 09 11 80    	pushl  0x801109e8
801014ed:	ff 35 e4 09 11 80    	pushl  0x801109e4
801014f3:	ff 35 e0 09 11 80    	pushl  0x801109e0
801014f9:	68 84 73 10 80       	push   $0x80107384
801014fe:	e8 5d f1 ff ff       	call   80100660 <cprintf>
}
80101503:	83 c4 30             	add    $0x30,%esp
80101506:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101509:	c9                   	leave  
8010150a:	c3                   	ret    
8010150b:	90                   	nop
8010150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101510 <ialloc>:
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	53                   	push   %ebx
80101516:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
{
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	8b 75 08             	mov    0x8(%ebp),%esi
80101526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	0f 86 91 00 00 00    	jbe    801015c0 <ialloc+0xb0>
8010152f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101534:	eb 21                	jmp    80101557 <ialloc+0x47>
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101540:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101543:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101546:	57                   	push   %edi
80101547:	e8 94 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010154c:	83 c4 10             	add    $0x10,%esp
8010154f:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101555:	76 69                	jbe    801015c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101557:	89 d8                	mov    %ebx,%eax
80101559:	83 ec 08             	sub    $0x8,%esp
8010155c:	c1 e8 03             	shr    $0x3,%eax
8010155f:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101565:	50                   	push   %eax
80101566:	56                   	push   %esi
80101567:	e8 64 eb ff ff       	call   801000d0 <bread>
8010156c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010156e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101570:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101573:	83 e0 07             	and    $0x7,%eax
80101576:	c1 e0 06             	shl    $0x6,%eax
80101579:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010157d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101581:	75 bd                	jne    80101540 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101589:	6a 40                	push   $0x40
8010158b:	6a 00                	push   $0x0
8010158d:	51                   	push   %ecx
8010158e:	e8 dd 31 00 00       	call   80104770 <memset>
      dip->type = type;
80101593:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010159a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010159d:	89 3c 24             	mov    %edi,(%esp)
801015a0:	e8 6b 18 00 00       	call   80102e10 <log_write>
      brelse(bp);
801015a5:	89 3c 24             	mov    %edi,(%esp)
801015a8:	e8 33 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ad:	83 c4 10             	add    $0x10,%esp
}
801015b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015b3:	89 da                	mov    %ebx,%edx
801015b5:	89 f0                	mov    %esi,%eax
}
801015b7:	5b                   	pop    %ebx
801015b8:	5e                   	pop    %esi
801015b9:	5f                   	pop    %edi
801015ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801015bb:	e9 50 fc ff ff       	jmp    80101210 <iget>
  panic("ialloc: no inodes");
801015c0:	83 ec 0c             	sub    $0xc,%esp
801015c3:	68 34 73 10 80       	push   $0x80107334
801015c8:	e8 c3 ed ff ff       	call   80100390 <panic>
801015cd:	8d 76 00             	lea    0x0(%esi),%esi

801015d0 <iupdate>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d8:	83 ec 08             	sub    $0x8,%esp
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015de:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e1:	c1 e8 03             	shr    $0x3,%eax
801015e4:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801015ea:	50                   	push   %eax
801015eb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ee:	e8 dd ea ff ff       	call   801000d0 <bread>
801015f3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015f8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ff:	83 e0 07             	and    $0x7,%eax
80101602:	c1 e0 06             	shl    $0x6,%eax
80101605:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101609:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010160c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101610:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101613:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101617:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010161b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010161f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101623:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101627:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010162a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162d:	6a 34                	push   $0x34
8010162f:	53                   	push   %ebx
80101630:	50                   	push   %eax
80101631:	e8 ea 31 00 00       	call   80104820 <memmove>
  log_write(bp);
80101636:	89 34 24             	mov    %esi,(%esp)
80101639:	e8 d2 17 00 00       	call   80102e10 <log_write>
  brelse(bp);
8010163e:	89 75 08             	mov    %esi,0x8(%ebp)
80101641:	83 c4 10             	add    $0x10,%esp
}
80101644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5d                   	pop    %ebp
  brelse(bp);
8010164a:	e9 91 eb ff ff       	jmp    801001e0 <brelse>
8010164f:	90                   	nop

80101650 <idup>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	83 ec 10             	sub    $0x10,%esp
80101657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010165a:	68 00 0a 11 80       	push   $0x80110a00
8010165f:	e8 fc 2e 00 00       	call   80104560 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010166f:	e8 ac 30 00 00       	call   80104720 <release>
}
80101674:	89 d8                	mov    %ebx,%eax
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ilock>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101688:	85 db                	test   %ebx,%ebx
8010168a:	0f 84 b4 00 00 00    	je     80101744 <ilock+0xc4>
80101690:	8b 43 08             	mov    0x8(%ebx),%eax
80101693:	85 c0                	test   %eax,%eax
80101695:	0f 8e a9 00 00 00    	jle    80101744 <ilock+0xc4>
  acquiresleep(&ip->lock);
8010169b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010169e:	83 ec 0c             	sub    $0xc,%esp
801016a1:	50                   	push   %eax
801016a2:	e8 c9 2d 00 00       	call   80104470 <acquiresleep>
  if(!(ip->flags & I_VALID)){
801016a7:	83 c4 10             	add    $0x10,%esp
801016aa:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
801016ae:	74 10                	je     801016c0 <ilock+0x40>
}
801016b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016b3:	5b                   	pop    %ebx
801016b4:	5e                   	pop    %esi
801016b5:	5d                   	pop    %ebp
801016b6:	c3                   	ret    
801016b7:	89 f6                	mov    %esi,%esi
801016b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016c0:	8b 43 04             	mov    0x4(%ebx),%eax
801016c3:	83 ec 08             	sub    $0x8,%esp
801016c6:	c1 e8 03             	shr    $0x3,%eax
801016c9:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801016cf:	50                   	push   %eax
801016d0:	ff 33                	pushl  (%ebx)
801016d2:	e8 f9 e9 ff ff       	call   801000d0 <bread>
801016d7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016d9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101703:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101707:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010170b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010170e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101711:	6a 34                	push   $0x34
80101713:	50                   	push   %eax
80101714:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101717:	50                   	push   %eax
80101718:	e8 03 31 00 00       	call   80104820 <memmove>
    brelse(bp);
8010171d:	89 34 24             	mov    %esi,(%esp)
80101720:	e8 bb ea ff ff       	call   801001e0 <brelse>
    ip->flags |= I_VALID;
80101725:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
80101729:	83 c4 10             	add    $0x10,%esp
8010172c:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101731:	0f 85 79 ff ff ff    	jne    801016b0 <ilock+0x30>
      panic("ilock: no type");
80101737:	83 ec 0c             	sub    $0xc,%esp
8010173a:	68 4c 73 10 80       	push   $0x8010734c
8010173f:	e8 4c ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101744:	83 ec 0c             	sub    $0xc,%esp
80101747:	68 46 73 10 80       	push   $0x80107346
8010174c:	e8 3f ec ff ff       	call   80100390 <panic>
80101751:	eb 0d                	jmp    80101760 <iunlock>
80101753:	90                   	nop
80101754:	90                   	nop
80101755:	90                   	nop
80101756:	90                   	nop
80101757:	90                   	nop
80101758:	90                   	nop
80101759:	90                   	nop
8010175a:	90                   	nop
8010175b:	90                   	nop
8010175c:	90                   	nop
8010175d:	90                   	nop
8010175e:	90                   	nop
8010175f:	90                   	nop

80101760 <iunlock>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	74 28                	je     80101794 <iunlock+0x34>
8010176c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010176f:	83 ec 0c             	sub    $0xc,%esp
80101772:	56                   	push   %esi
80101773:	e8 98 2d 00 00       	call   80104510 <holdingsleep>
80101778:	83 c4 10             	add    $0x10,%esp
8010177b:	85 c0                	test   %eax,%eax
8010177d:	74 15                	je     80101794 <iunlock+0x34>
8010177f:	8b 43 08             	mov    0x8(%ebx),%eax
80101782:	85 c0                	test   %eax,%eax
80101784:	7e 0e                	jle    80101794 <iunlock+0x34>
  releasesleep(&ip->lock);
80101786:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101789:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010178c:	5b                   	pop    %ebx
8010178d:	5e                   	pop    %esi
8010178e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010178f:	e9 3c 2d 00 00       	jmp    801044d0 <releasesleep>
    panic("iunlock");
80101794:	83 ec 0c             	sub    $0xc,%esp
80101797:	68 5b 73 10 80       	push   $0x8010735b
8010179c:	e8 ef eb ff ff       	call   80100390 <panic>
801017a1:	eb 0d                	jmp    801017b0 <iput>
801017a3:	90                   	nop
801017a4:	90                   	nop
801017a5:	90                   	nop
801017a6:	90                   	nop
801017a7:	90                   	nop
801017a8:	90                   	nop
801017a9:	90                   	nop
801017aa:	90                   	nop
801017ab:	90                   	nop
801017ac:	90                   	nop
801017ad:	90                   	nop
801017ae:	90                   	nop
801017af:	90                   	nop

801017b0 <iput>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	83 ec 28             	sub    $0x28,%esp
801017b9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
801017bc:	68 00 0a 11 80       	push   $0x80110a00
801017c1:	e8 9a 2d 00 00       	call   80104560 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017c6:	8b 46 08             	mov    0x8(%esi),%eax
801017c9:	83 c4 10             	add    $0x10,%esp
801017cc:	83 f8 01             	cmp    $0x1,%eax
801017cf:	74 1f                	je     801017f0 <iput+0x40>
  ip->ref--;
801017d1:	83 e8 01             	sub    $0x1,%eax
801017d4:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801017d7:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
801017de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017e1:	5b                   	pop    %ebx
801017e2:	5e                   	pop    %esi
801017e3:	5f                   	pop    %edi
801017e4:	5d                   	pop    %ebp
  release(&icache.lock);
801017e5:	e9 36 2f 00 00       	jmp    80104720 <release>
801017ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017f0:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
801017f4:	74 db                	je     801017d1 <iput+0x21>
801017f6:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017fb:	75 d4                	jne    801017d1 <iput+0x21>
    release(&icache.lock);
801017fd:	83 ec 0c             	sub    $0xc,%esp
80101800:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101803:	8d be 8c 00 00 00    	lea    0x8c(%esi),%edi
80101809:	68 00 0a 11 80       	push   $0x80110a00
8010180e:	e8 0d 2f 00 00       	call   80104720 <release>
80101813:	83 c4 10             	add    $0x10,%esp
80101816:	eb 0f                	jmp    80101827 <iput+0x77>
80101818:	90                   	nop
80101819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101820:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101823:	39 fb                	cmp    %edi,%ebx
80101825:	74 19                	je     80101840 <iput+0x90>
    if(ip->addrs[i]){
80101827:	8b 13                	mov    (%ebx),%edx
80101829:	85 d2                	test   %edx,%edx
8010182b:	74 f3                	je     80101820 <iput+0x70>
      bfree(ip->dev, ip->addrs[i]);
8010182d:	8b 06                	mov    (%esi),%eax
8010182f:	e8 cc fb ff ff       	call   80101400 <bfree>
      ip->addrs[i] = 0;
80101834:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010183a:	eb e4                	jmp    80101820 <iput+0x70>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101840:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101846:	85 c0                	test   %eax,%eax
80101848:	75 46                	jne    80101890 <iput+0xe0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010184a:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
8010184d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101854:	56                   	push   %esi
80101855:	e8 76 fd ff ff       	call   801015d0 <iupdate>
    ip->type = 0;
8010185a:	31 c0                	xor    %eax,%eax
8010185c:	66 89 46 50          	mov    %ax,0x50(%esi)
    iupdate(ip);
80101860:	89 34 24             	mov    %esi,(%esp)
80101863:	e8 68 fd ff ff       	call   801015d0 <iupdate>
    acquire(&icache.lock);
80101868:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010186f:	e8 ec 2c 00 00       	call   80104560 <acquire>
    ip->flags = 0;
80101874:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
8010187b:	8b 46 08             	mov    0x8(%esi),%eax
8010187e:	83 c4 10             	add    $0x10,%esp
80101881:	e9 4b ff ff ff       	jmp    801017d1 <iput+0x21>
80101886:	8d 76 00             	lea    0x0(%esi),%esi
80101889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101890:	83 ec 08             	sub    $0x8,%esp
80101893:	50                   	push   %eax
80101894:	ff 36                	pushl  (%esi)
80101896:	e8 35 e8 ff ff       	call   801000d0 <bread>
8010189b:	83 c4 10             	add    $0x10,%esp
8010189e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018a1:	8d 58 5c             	lea    0x5c(%eax),%ebx
801018a4:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
801018aa:	eb 0b                	jmp    801018b7 <iput+0x107>
801018ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018b0:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
801018b3:	39 df                	cmp    %ebx,%edi
801018b5:	74 0f                	je     801018c6 <iput+0x116>
      if(a[j])
801018b7:	8b 13                	mov    (%ebx),%edx
801018b9:	85 d2                	test   %edx,%edx
801018bb:	74 f3                	je     801018b0 <iput+0x100>
        bfree(ip->dev, a[j]);
801018bd:	8b 06                	mov    (%esi),%eax
801018bf:	e8 3c fb ff ff       	call   80101400 <bfree>
801018c4:	eb ea                	jmp    801018b0 <iput+0x100>
    brelse(bp);
801018c6:	83 ec 0c             	sub    $0xc,%esp
801018c9:	ff 75 e4             	pushl  -0x1c(%ebp)
801018cc:	e8 0f e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018d1:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018d7:	8b 06                	mov    (%esi),%eax
801018d9:	e8 22 fb ff ff       	call   80101400 <bfree>
    ip->addrs[NDIRECT] = 0;
801018de:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018e5:	00 00 00 
801018e8:	83 c4 10             	add    $0x10,%esp
801018eb:	e9 5a ff ff ff       	jmp    8010184a <iput+0x9a>

801018f0 <iunlockput>:
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	53                   	push   %ebx
801018f4:	83 ec 10             	sub    $0x10,%esp
801018f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801018fa:	53                   	push   %ebx
801018fb:	e8 60 fe ff ff       	call   80101760 <iunlock>
  iput(ip);
80101900:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101903:	83 c4 10             	add    $0x10,%esp
}
80101906:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101909:	c9                   	leave  
  iput(ip);
8010190a:	e9 a1 fe ff ff       	jmp    801017b0 <iput>
8010190f:	90                   	nop

80101910 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	8b 55 08             	mov    0x8(%ebp),%edx
80101916:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101919:	8b 0a                	mov    (%edx),%ecx
8010191b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010191e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101921:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101924:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101928:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010192b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010192f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101933:	8b 52 58             	mov    0x58(%edx),%edx
80101936:	89 50 10             	mov    %edx,0x10(%eax)
}
80101939:	5d                   	pop    %ebp
8010193a:	c3                   	ret    
8010193b:	90                   	nop
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101940 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	57                   	push   %edi
80101944:	56                   	push   %esi
80101945:	53                   	push   %ebx
80101946:	83 ec 1c             	sub    $0x1c,%esp
80101949:	8b 45 08             	mov    0x8(%ebp),%eax
8010194c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010194f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101952:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101957:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010195a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010195d:	8b 75 10             	mov    0x10(%ebp),%esi
80101960:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101963:	0f 84 a7 00 00 00    	je     80101a10 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101969:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010196c:	8b 40 58             	mov    0x58(%eax),%eax
8010196f:	39 c6                	cmp    %eax,%esi
80101971:	0f 87 ba 00 00 00    	ja     80101a31 <readi+0xf1>
80101977:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010197a:	89 f9                	mov    %edi,%ecx
8010197c:	01 f1                	add    %esi,%ecx
8010197e:	0f 82 ad 00 00 00    	jb     80101a31 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101984:	89 c2                	mov    %eax,%edx
80101986:	29 f2                	sub    %esi,%edx
80101988:	39 c8                	cmp    %ecx,%eax
8010198a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010198d:	31 ff                	xor    %edi,%edi
8010198f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101991:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101994:	74 6c                	je     80101a02 <readi+0xc2>
80101996:	8d 76 00             	lea    0x0(%esi),%esi
80101999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019a0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019a3:	89 f2                	mov    %esi,%edx
801019a5:	c1 ea 09             	shr    $0x9,%edx
801019a8:	89 d8                	mov    %ebx,%eax
801019aa:	e8 31 f9 ff ff       	call   801012e0 <bmap>
801019af:	83 ec 08             	sub    $0x8,%esp
801019b2:	50                   	push   %eax
801019b3:	ff 33                	pushl  (%ebx)
801019b5:	e8 16 e7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019ba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019bd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019bf:	89 f0                	mov    %esi,%eax
801019c1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019c6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019cb:	83 c4 0c             	add    $0xc,%esp
801019ce:	29 c1                	sub    %eax,%ecx
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019d0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801019d4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801019d7:	29 fb                	sub    %edi,%ebx
801019d9:	39 d9                	cmp    %ebx,%ecx
801019db:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019de:	53                   	push   %ebx
801019df:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019e0:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
801019e2:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019e5:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
801019e7:	e8 34 2e 00 00       	call   80104820 <memmove>
    brelse(bp);
801019ec:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019ef:	89 14 24             	mov    %edx,(%esp)
801019f2:	e8 e9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f7:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019fa:	83 c4 10             	add    $0x10,%esp
801019fd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a00:	77 9e                	ja     801019a0 <readi+0x60>
  }
  return n;
80101a02:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a05:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a08:	5b                   	pop    %ebx
80101a09:	5e                   	pop    %esi
80101a0a:	5f                   	pop    %edi
80101a0b:	5d                   	pop    %ebp
80101a0c:	c3                   	ret    
80101a0d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a14:	66 83 f8 09          	cmp    $0x9,%ax
80101a18:	77 17                	ja     80101a31 <readi+0xf1>
80101a1a:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101a21:	85 c0                	test   %eax,%eax
80101a23:	74 0c                	je     80101a31 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a25:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a2b:	5b                   	pop    %ebx
80101a2c:	5e                   	pop    %esi
80101a2d:	5f                   	pop    %edi
80101a2e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a2f:	ff e0                	jmp    *%eax
      return -1;
80101a31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a36:	eb cd                	jmp    80101a05 <readi+0xc5>
80101a38:	90                   	nop
80101a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a40 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	57                   	push   %edi
80101a44:	56                   	push   %esi
80101a45:	53                   	push   %ebx
80101a46:	83 ec 1c             	sub    $0x1c,%esp
80101a49:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a4f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a57:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a5d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a60:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a63:	0f 84 b7 00 00 00    	je     80101b20 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a6c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a6f:	0f 82 eb 00 00 00    	jb     80101b60 <writei+0x120>
80101a75:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a78:	31 d2                	xor    %edx,%edx
80101a7a:	89 f8                	mov    %edi,%eax
80101a7c:	01 f0                	add    %esi,%eax
80101a7e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a81:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a86:	0f 87 d4 00 00 00    	ja     80101b60 <writei+0x120>
80101a8c:	85 d2                	test   %edx,%edx
80101a8e:	0f 85 cc 00 00 00    	jne    80101b60 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a94:	85 ff                	test   %edi,%edi
80101a96:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a9d:	74 72                	je     80101b11 <writei+0xd1>
80101a9f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aa0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101aa3:	89 f2                	mov    %esi,%edx
80101aa5:	c1 ea 09             	shr    $0x9,%edx
80101aa8:	89 f8                	mov    %edi,%eax
80101aaa:	e8 31 f8 ff ff       	call   801012e0 <bmap>
80101aaf:	83 ec 08             	sub    $0x8,%esp
80101ab2:	50                   	push   %eax
80101ab3:	ff 37                	pushl  (%edi)
80101ab5:	e8 16 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aba:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101abd:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ac2:	89 f0                	mov    %esi,%eax
80101ac4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ac9:	83 c4 0c             	add    $0xc,%esp
80101acc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ad1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ad3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ad7:	39 d9                	cmp    %ebx,%ecx
80101ad9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101adc:	53                   	push   %ebx
80101add:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ae0:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101ae2:	50                   	push   %eax
80101ae3:	e8 38 2d 00 00       	call   80104820 <memmove>
    log_write(bp);
80101ae8:	89 3c 24             	mov    %edi,(%esp)
80101aeb:	e8 20 13 00 00       	call   80102e10 <log_write>
    brelse(bp);
80101af0:	89 3c 24             	mov    %edi,(%esp)
80101af3:	e8 e8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101afb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101afe:	83 c4 10             	add    $0x10,%esp
80101b01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b04:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b07:	77 97                	ja     80101aa0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b09:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b0c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b0f:	77 37                	ja     80101b48 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b11:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b17:	5b                   	pop    %ebx
80101b18:	5e                   	pop    %esi
80101b19:	5f                   	pop    %edi
80101b1a:	5d                   	pop    %ebp
80101b1b:	c3                   	ret    
80101b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b24:	66 83 f8 09          	cmp    $0x9,%ax
80101b28:	77 36                	ja     80101b60 <writei+0x120>
80101b2a:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101b31:	85 c0                	test   %eax,%eax
80101b33:	74 2b                	je     80101b60 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b35:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b3b:	5b                   	pop    %ebx
80101b3c:	5e                   	pop    %esi
80101b3d:	5f                   	pop    %edi
80101b3e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b3f:	ff e0                	jmp    *%eax
80101b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b48:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b4b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b4e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b51:	50                   	push   %eax
80101b52:	e8 79 fa ff ff       	call   801015d0 <iupdate>
80101b57:	83 c4 10             	add    $0x10,%esp
80101b5a:	eb b5                	jmp    80101b11 <writei+0xd1>
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b65:	eb ad                	jmp    80101b14 <writei+0xd4>
80101b67:	89 f6                	mov    %esi,%esi
80101b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b70 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b76:	6a 0e                	push   $0xe
80101b78:	ff 75 0c             	pushl  0xc(%ebp)
80101b7b:	ff 75 08             	pushl  0x8(%ebp)
80101b7e:	e8 1d 2d 00 00       	call   801048a0 <strncmp>
}
80101b83:	c9                   	leave  
80101b84:	c3                   	ret    
80101b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	83 ec 1c             	sub    $0x1c,%esp
80101b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ba1:	0f 85 85 00 00 00    	jne    80101c2c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ba7:	8b 53 58             	mov    0x58(%ebx),%edx
80101baa:	31 ff                	xor    %edi,%edi
80101bac:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101baf:	85 d2                	test   %edx,%edx
80101bb1:	74 3e                	je     80101bf1 <dirlookup+0x61>
80101bb3:	90                   	nop
80101bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bb8:	6a 10                	push   $0x10
80101bba:	57                   	push   %edi
80101bbb:	56                   	push   %esi
80101bbc:	53                   	push   %ebx
80101bbd:	e8 7e fd ff ff       	call   80101940 <readi>
80101bc2:	83 c4 10             	add    $0x10,%esp
80101bc5:	83 f8 10             	cmp    $0x10,%eax
80101bc8:	75 55                	jne    80101c1f <dirlookup+0x8f>
      panic("dirlink read");
    if(de.inum == 0)
80101bca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bcf:	74 18                	je     80101be9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101bd1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bd4:	83 ec 04             	sub    $0x4,%esp
80101bd7:	6a 0e                	push   $0xe
80101bd9:	50                   	push   %eax
80101bda:	ff 75 0c             	pushl  0xc(%ebp)
80101bdd:	e8 be 2c 00 00       	call   801048a0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101be2:	83 c4 10             	add    $0x10,%esp
80101be5:	85 c0                	test   %eax,%eax
80101be7:	74 17                	je     80101c00 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101be9:	83 c7 10             	add    $0x10,%edi
80101bec:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101bef:	72 c7                	jb     80101bb8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101bf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101bf4:	31 c0                	xor    %eax,%eax
}
80101bf6:	5b                   	pop    %ebx
80101bf7:	5e                   	pop    %esi
80101bf8:	5f                   	pop    %edi
80101bf9:	5d                   	pop    %ebp
80101bfa:	c3                   	ret    
80101bfb:	90                   	nop
80101bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c00:	8b 45 10             	mov    0x10(%ebp),%eax
80101c03:	85 c0                	test   %eax,%eax
80101c05:	74 05                	je     80101c0c <dirlookup+0x7c>
        *poff = off;
80101c07:	8b 45 10             	mov    0x10(%ebp),%eax
80101c0a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c0c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c10:	8b 03                	mov    (%ebx),%eax
80101c12:	e8 f9 f5 ff ff       	call   80101210 <iget>
}
80101c17:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c1a:	5b                   	pop    %ebx
80101c1b:	5e                   	pop    %esi
80101c1c:	5f                   	pop    %edi
80101c1d:	5d                   	pop    %ebp
80101c1e:	c3                   	ret    
      panic("dirlink read");
80101c1f:	83 ec 0c             	sub    $0xc,%esp
80101c22:	68 75 73 10 80       	push   $0x80107375
80101c27:	e8 64 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c2c:	83 ec 0c             	sub    $0xc,%esp
80101c2f:	68 63 73 10 80       	push   $0x80107363
80101c34:	e8 57 e7 ff ff       	call   80100390 <panic>
80101c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	57                   	push   %edi
80101c44:	56                   	push   %esi
80101c45:	53                   	push   %ebx
80101c46:	89 cf                	mov    %ecx,%edi
80101c48:	89 c3                	mov    %eax,%ebx
80101c4a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c4d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c50:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c53:	0f 84 67 01 00 00    	je     80101dc0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101c59:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  acquire(&icache.lock);
80101c5f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(proc->cwd);
80101c62:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c65:	68 00 0a 11 80       	push   $0x80110a00
80101c6a:	e8 f1 28 00 00       	call   80104560 <acquire>
  ip->ref++;
80101c6f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c73:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c7a:	e8 a1 2a 00 00       	call   80104720 <release>
80101c7f:	83 c4 10             	add    $0x10,%esp
80101c82:	eb 07                	jmp    80101c8b <namex+0x4b>
80101c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101c88:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101c8b:	0f b6 03             	movzbl (%ebx),%eax
80101c8e:	3c 2f                	cmp    $0x2f,%al
80101c90:	74 f6                	je     80101c88 <namex+0x48>
  if(*path == 0)
80101c92:	84 c0                	test   %al,%al
80101c94:	0f 84 ee 00 00 00    	je     80101d88 <namex+0x148>
  while(*path != '/' && *path != 0)
80101c9a:	0f b6 03             	movzbl (%ebx),%eax
80101c9d:	3c 2f                	cmp    $0x2f,%al
80101c9f:	0f 84 b3 00 00 00    	je     80101d58 <namex+0x118>
80101ca5:	84 c0                	test   %al,%al
80101ca7:	89 da                	mov    %ebx,%edx
80101ca9:	75 09                	jne    80101cb4 <namex+0x74>
80101cab:	e9 a8 00 00 00       	jmp    80101d58 <namex+0x118>
80101cb0:	84 c0                	test   %al,%al
80101cb2:	74 0a                	je     80101cbe <namex+0x7e>
    path++;
80101cb4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cb7:	0f b6 02             	movzbl (%edx),%eax
80101cba:	3c 2f                	cmp    $0x2f,%al
80101cbc:	75 f2                	jne    80101cb0 <namex+0x70>
80101cbe:	89 d1                	mov    %edx,%ecx
80101cc0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101cc2:	83 f9 0d             	cmp    $0xd,%ecx
80101cc5:	0f 8e 91 00 00 00    	jle    80101d5c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101ccb:	83 ec 04             	sub    $0x4,%esp
80101cce:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cd1:	6a 0e                	push   $0xe
80101cd3:	53                   	push   %ebx
80101cd4:	57                   	push   %edi
80101cd5:	e8 46 2b 00 00       	call   80104820 <memmove>
    path++;
80101cda:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101cdd:	83 c4 10             	add    $0x10,%esp
    path++;
80101ce0:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101ce2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101ce5:	75 11                	jne    80101cf8 <namex+0xb8>
80101ce7:	89 f6                	mov    %esi,%esi
80101ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cf0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cf3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101cf6:	74 f8                	je     80101cf0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101cf8:	83 ec 0c             	sub    $0xc,%esp
80101cfb:	56                   	push   %esi
80101cfc:	e8 7f f9 ff ff       	call   80101680 <ilock>
    if(ip->type != T_DIR){
80101d01:	83 c4 10             	add    $0x10,%esp
80101d04:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d09:	0f 85 91 00 00 00    	jne    80101da0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d0f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d12:	85 d2                	test   %edx,%edx
80101d14:	74 09                	je     80101d1f <namex+0xdf>
80101d16:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d19:	0f 84 b7 00 00 00    	je     80101dd6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d1f:	83 ec 04             	sub    $0x4,%esp
80101d22:	6a 00                	push   $0x0
80101d24:	57                   	push   %edi
80101d25:	56                   	push   %esi
80101d26:	e8 65 fe ff ff       	call   80101b90 <dirlookup>
80101d2b:	83 c4 10             	add    $0x10,%esp
80101d2e:	85 c0                	test   %eax,%eax
80101d30:	74 6e                	je     80101da0 <namex+0x160>
  iunlock(ip);
80101d32:	83 ec 0c             	sub    $0xc,%esp
80101d35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d38:	56                   	push   %esi
80101d39:	e8 22 fa ff ff       	call   80101760 <iunlock>
  iput(ip);
80101d3e:	89 34 24             	mov    %esi,(%esp)
80101d41:	e8 6a fa ff ff       	call   801017b0 <iput>
80101d46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d49:	83 c4 10             	add    $0x10,%esp
80101d4c:	89 c6                	mov    %eax,%esi
80101d4e:	e9 38 ff ff ff       	jmp    80101c8b <namex+0x4b>
80101d53:	90                   	nop
80101d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d58:	89 da                	mov    %ebx,%edx
80101d5a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d5c:	83 ec 04             	sub    $0x4,%esp
80101d5f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d62:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d65:	51                   	push   %ecx
80101d66:	53                   	push   %ebx
80101d67:	57                   	push   %edi
80101d68:	e8 b3 2a 00 00       	call   80104820 <memmove>
    name[len] = 0;
80101d6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d70:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d73:	83 c4 10             	add    $0x10,%esp
80101d76:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d7a:	89 d3                	mov    %edx,%ebx
80101d7c:	e9 61 ff ff ff       	jmp    80101ce2 <namex+0xa2>
80101d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d88:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d8b:	85 c0                	test   %eax,%eax
80101d8d:	75 5d                	jne    80101dec <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101d8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d92:	89 f0                	mov    %esi,%eax
80101d94:	5b                   	pop    %ebx
80101d95:	5e                   	pop    %esi
80101d96:	5f                   	pop    %edi
80101d97:	5d                   	pop    %ebp
80101d98:	c3                   	ret    
80101d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101da0:	83 ec 0c             	sub    $0xc,%esp
80101da3:	56                   	push   %esi
80101da4:	e8 b7 f9 ff ff       	call   80101760 <iunlock>
  iput(ip);
80101da9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dac:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dae:	e8 fd f9 ff ff       	call   801017b0 <iput>
      return 0;
80101db3:	83 c4 10             	add    $0x10,%esp
}
80101db6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db9:	89 f0                	mov    %esi,%eax
80101dbb:	5b                   	pop    %ebx
80101dbc:	5e                   	pop    %esi
80101dbd:	5f                   	pop    %edi
80101dbe:	5d                   	pop    %ebp
80101dbf:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101dc0:	ba 01 00 00 00       	mov    $0x1,%edx
80101dc5:	b8 01 00 00 00       	mov    $0x1,%eax
80101dca:	e8 41 f4 ff ff       	call   80101210 <iget>
80101dcf:	89 c6                	mov    %eax,%esi
80101dd1:	e9 b5 fe ff ff       	jmp    80101c8b <namex+0x4b>
      iunlock(ip);
80101dd6:	83 ec 0c             	sub    $0xc,%esp
80101dd9:	56                   	push   %esi
80101dda:	e8 81 f9 ff ff       	call   80101760 <iunlock>
      return ip;
80101ddf:	83 c4 10             	add    $0x10,%esp
}
80101de2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de5:	89 f0                	mov    %esi,%eax
80101de7:	5b                   	pop    %ebx
80101de8:	5e                   	pop    %esi
80101de9:	5f                   	pop    %edi
80101dea:	5d                   	pop    %ebp
80101deb:	c3                   	ret    
    iput(ip);
80101dec:	83 ec 0c             	sub    $0xc,%esp
80101def:	56                   	push   %esi
    return 0;
80101df0:	31 f6                	xor    %esi,%esi
    iput(ip);
80101df2:	e8 b9 f9 ff ff       	call   801017b0 <iput>
    return 0;
80101df7:	83 c4 10             	add    $0x10,%esp
80101dfa:	eb 93                	jmp    80101d8f <namex+0x14f>
80101dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e00 <dirlink>:
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	83 ec 20             	sub    $0x20,%esp
80101e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e0c:	6a 00                	push   $0x0
80101e0e:	ff 75 0c             	pushl  0xc(%ebp)
80101e11:	53                   	push   %ebx
80101e12:	e8 79 fd ff ff       	call   80101b90 <dirlookup>
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	85 c0                	test   %eax,%eax
80101e1c:	75 67                	jne    80101e85 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e24:	85 ff                	test   %edi,%edi
80101e26:	74 29                	je     80101e51 <dirlink+0x51>
80101e28:	31 ff                	xor    %edi,%edi
80101e2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e2d:	eb 09                	jmp    80101e38 <dirlink+0x38>
80101e2f:	90                   	nop
80101e30:	83 c7 10             	add    $0x10,%edi
80101e33:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e36:	73 19                	jae    80101e51 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e38:	6a 10                	push   $0x10
80101e3a:	57                   	push   %edi
80101e3b:	56                   	push   %esi
80101e3c:	53                   	push   %ebx
80101e3d:	e8 fe fa ff ff       	call   80101940 <readi>
80101e42:	83 c4 10             	add    $0x10,%esp
80101e45:	83 f8 10             	cmp    $0x10,%eax
80101e48:	75 4e                	jne    80101e98 <dirlink+0x98>
    if(de.inum == 0)
80101e4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e4f:	75 df                	jne    80101e30 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e51:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e54:	83 ec 04             	sub    $0x4,%esp
80101e57:	6a 0e                	push   $0xe
80101e59:	ff 75 0c             	pushl  0xc(%ebp)
80101e5c:	50                   	push   %eax
80101e5d:	e8 ae 2a 00 00       	call   80104910 <strncpy>
  de.inum = inum;
80101e62:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e65:	6a 10                	push   $0x10
80101e67:	57                   	push   %edi
80101e68:	56                   	push   %esi
80101e69:	53                   	push   %ebx
  de.inum = inum;
80101e6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e6e:	e8 cd fb ff ff       	call   80101a40 <writei>
80101e73:	83 c4 20             	add    $0x20,%esp
80101e76:	83 f8 10             	cmp    $0x10,%eax
80101e79:	75 2a                	jne    80101ea5 <dirlink+0xa5>
  return 0;
80101e7b:	31 c0                	xor    %eax,%eax
}
80101e7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e80:	5b                   	pop    %ebx
80101e81:	5e                   	pop    %esi
80101e82:	5f                   	pop    %edi
80101e83:	5d                   	pop    %ebp
80101e84:	c3                   	ret    
    iput(ip);
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	50                   	push   %eax
80101e89:	e8 22 f9 ff ff       	call   801017b0 <iput>
    return -1;
80101e8e:	83 c4 10             	add    $0x10,%esp
80101e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e96:	eb e5                	jmp    80101e7d <dirlink+0x7d>
      panic("dirlink read");
80101e98:	83 ec 0c             	sub    $0xc,%esp
80101e9b:	68 75 73 10 80       	push   $0x80107375
80101ea0:	e8 eb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 c6 79 10 80       	push   $0x801079c6
80101ead:	e8 de e4 ff ff       	call   80100390 <panic>
80101eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ec0 <namei>:

struct inode*
namei(char *path)
{
80101ec0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ec1:	31 d2                	xor    %edx,%edx
{
80101ec3:	89 e5                	mov    %esp,%ebp
80101ec5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ece:	e8 6d fd ff ff       	call   80101c40 <namex>
}
80101ed3:	c9                   	leave  
80101ed4:	c3                   	ret    
80101ed5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ee0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ee1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101ee6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ee8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101eee:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101eef:	e9 4c fd ff ff       	jmp    80101c40 <namex>
80101ef4:	66 90                	xchg   %ax,%ax
80101ef6:	66 90                	xchg   %ax,%ax
80101ef8:	66 90                	xchg   %ax,%ax
80101efa:	66 90                	xchg   %ax,%ax
80101efc:	66 90                	xchg   %ax,%ax
80101efe:	66 90                	xchg   %ax,%ax

80101f00 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	57                   	push   %edi
80101f04:	56                   	push   %esi
80101f05:	53                   	push   %ebx
80101f06:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f09:	85 c0                	test   %eax,%eax
80101f0b:	0f 84 b4 00 00 00    	je     80101fc5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f11:	8b 58 08             	mov    0x8(%eax),%ebx
80101f14:	89 c6                	mov    %eax,%esi
80101f16:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f1c:	0f 87 96 00 00 00    	ja     80101fb8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f22:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f27:	89 f6                	mov    %esi,%esi
80101f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f30:	89 ca                	mov    %ecx,%edx
80101f32:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f33:	83 e0 c0             	and    $0xffffffc0,%eax
80101f36:	3c 40                	cmp    $0x40,%al
80101f38:	75 f6                	jne    80101f30 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f3a:	31 ff                	xor    %edi,%edi
80101f3c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f41:	89 f8                	mov    %edi,%eax
80101f43:	ee                   	out    %al,(%dx)
80101f44:	b8 01 00 00 00       	mov    $0x1,%eax
80101f49:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f4e:	ee                   	out    %al,(%dx)
80101f4f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f54:	89 d8                	mov    %ebx,%eax
80101f56:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f57:	89 d8                	mov    %ebx,%eax
80101f59:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f5e:	c1 f8 08             	sar    $0x8,%eax
80101f61:	ee                   	out    %al,(%dx)
80101f62:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f67:	89 f8                	mov    %edi,%eax
80101f69:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f6a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f6e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f73:	c1 e0 04             	shl    $0x4,%eax
80101f76:	83 e0 10             	and    $0x10,%eax
80101f79:	83 c8 e0             	or     $0xffffffe0,%eax
80101f7c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f7d:	f6 06 04             	testb  $0x4,(%esi)
80101f80:	75 16                	jne    80101f98 <idestart+0x98>
80101f82:	b8 20 00 00 00       	mov    $0x20,%eax
80101f87:	89 ca                	mov    %ecx,%edx
80101f89:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f8d:	5b                   	pop    %ebx
80101f8e:	5e                   	pop    %esi
80101f8f:	5f                   	pop    %edi
80101f90:	5d                   	pop    %ebp
80101f91:	c3                   	ret    
80101f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f98:	b8 30 00 00 00       	mov    $0x30,%eax
80101f9d:	89 ca                	mov    %ecx,%edx
80101f9f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fa0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fa5:	83 c6 5c             	add    $0x5c,%esi
80101fa8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fad:	fc                   	cld    
80101fae:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fb3:	5b                   	pop    %ebx
80101fb4:	5e                   	pop    %esi
80101fb5:	5f                   	pop    %edi
80101fb6:	5d                   	pop    %ebp
80101fb7:	c3                   	ret    
    panic("incorrect blockno");
80101fb8:	83 ec 0c             	sub    $0xc,%esp
80101fbb:	68 e0 73 10 80       	push   $0x801073e0
80101fc0:	e8 cb e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101fc5:	83 ec 0c             	sub    $0xc,%esp
80101fc8:	68 d7 73 10 80       	push   $0x801073d7
80101fcd:	e8 be e3 ff ff       	call   80100390 <panic>
80101fd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fe0 <ideinit>:
{
80101fe0:	55                   	push   %ebp
80101fe1:	89 e5                	mov    %esp,%ebp
80101fe3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101fe6:	68 f2 73 10 80       	push   $0x801073f2
80101feb:	68 80 a5 10 80       	push   $0x8010a580
80101ff0:	e8 4b 25 00 00       	call   80104540 <initlock>
  picenable(IRQ_IDE);
80101ff5:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80101ffc:	e8 0f 13 00 00       	call   80103310 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102001:	58                   	pop    %eax
80102002:	a1 80 2d 11 80       	mov    0x80112d80,%eax
80102007:	5a                   	pop    %edx
80102008:	83 e8 01             	sub    $0x1,%eax
8010200b:	50                   	push   %eax
8010200c:	6a 0e                	push   $0xe
8010200e:	e8 cd 02 00 00       	call   801022e0 <ioapicenable>
80102013:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102016:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010201b:	90                   	nop
8010201c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102020:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102021:	83 e0 c0             	and    $0xffffffc0,%eax
80102024:	3c 40                	cmp    $0x40,%al
80102026:	75 f8                	jne    80102020 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102028:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010202d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102032:	ee                   	out    %al,(%dx)
80102033:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102038:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010203d:	eb 06                	jmp    80102045 <ideinit+0x65>
8010203f:	90                   	nop
  for(i=0; i<1000; i++){
80102040:	83 e9 01             	sub    $0x1,%ecx
80102043:	74 0f                	je     80102054 <ideinit+0x74>
80102045:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102046:	84 c0                	test   %al,%al
80102048:	74 f6                	je     80102040 <ideinit+0x60>
      havedisk1 = 1;
8010204a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102051:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102054:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102059:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010205e:	ee                   	out    %al,(%dx)
}
8010205f:	c9                   	leave  
80102060:	c3                   	ret    
80102061:	eb 0d                	jmp    80102070 <ideintr>
80102063:	90                   	nop
80102064:	90                   	nop
80102065:	90                   	nop
80102066:	90                   	nop
80102067:	90                   	nop
80102068:	90                   	nop
80102069:	90                   	nop
8010206a:	90                   	nop
8010206b:	90                   	nop
8010206c:	90                   	nop
8010206d:	90                   	nop
8010206e:	90                   	nop
8010206f:	90                   	nop

80102070 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102070:	55                   	push   %ebp
80102071:	89 e5                	mov    %esp,%ebp
80102073:	57                   	push   %edi
80102074:	56                   	push   %esi
80102075:	53                   	push   %ebx
80102076:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102079:	68 80 a5 10 80       	push   $0x8010a580
8010207e:	e8 dd 24 00 00       	call   80104560 <acquire>
  if((b = idequeue) == 0){
80102083:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102089:	83 c4 10             	add    $0x10,%esp
8010208c:	85 db                	test   %ebx,%ebx
8010208e:	74 67                	je     801020f7 <ideintr+0x87>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
80102090:	8b 43 58             	mov    0x58(%ebx),%eax
80102093:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102098:	8b 3b                	mov    (%ebx),%edi
8010209a:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020a0:	75 31                	jne    801020d3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020a2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020a7:	89 f6                	mov    %esi,%esi
801020a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020b0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020b1:	89 c6                	mov    %eax,%esi
801020b3:	83 e6 c0             	and    $0xffffffc0,%esi
801020b6:	89 f1                	mov    %esi,%ecx
801020b8:	80 f9 40             	cmp    $0x40,%cl
801020bb:	75 f3                	jne    801020b0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020bd:	a8 21                	test   $0x21,%al
801020bf:	75 12                	jne    801020d3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020c1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020c4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020c9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020ce:	fc                   	cld    
801020cf:	f3 6d                	rep insl (%dx),%es:(%edi)
801020d1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020d3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801020d6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801020d9:	89 f9                	mov    %edi,%ecx
801020db:	83 c9 02             	or     $0x2,%ecx
801020de:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801020e0:	53                   	push   %ebx
801020e1:	e8 fa 1f 00 00       	call   801040e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020e6:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020eb:	83 c4 10             	add    $0x10,%esp
801020ee:	85 c0                	test   %eax,%eax
801020f0:	74 05                	je     801020f7 <ideintr+0x87>
    idestart(idequeue);
801020f2:	e8 09 fe ff ff       	call   80101f00 <idestart>
    release(&idelock);
801020f7:	83 ec 0c             	sub    $0xc,%esp
801020fa:	68 80 a5 10 80       	push   $0x8010a580
801020ff:	e8 1c 26 00 00       	call   80104720 <release>

  release(&idelock);
}
80102104:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102107:	5b                   	pop    %ebx
80102108:	5e                   	pop    %esi
80102109:	5f                   	pop    %edi
8010210a:	5d                   	pop    %ebp
8010210b:	c3                   	ret    
8010210c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102110 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102110:	55                   	push   %ebp
80102111:	89 e5                	mov    %esp,%ebp
80102113:	53                   	push   %ebx
80102114:	83 ec 10             	sub    $0x10,%esp
80102117:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010211a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010211d:	50                   	push   %eax
8010211e:	e8 ed 23 00 00       	call   80104510 <holdingsleep>
80102123:	83 c4 10             	add    $0x10,%esp
80102126:	85 c0                	test   %eax,%eax
80102128:	0f 84 c6 00 00 00    	je     801021f4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010212e:	8b 03                	mov    (%ebx),%eax
80102130:	83 e0 06             	and    $0x6,%eax
80102133:	83 f8 02             	cmp    $0x2,%eax
80102136:	0f 84 ab 00 00 00    	je     801021e7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010213c:	8b 53 04             	mov    0x4(%ebx),%edx
8010213f:	85 d2                	test   %edx,%edx
80102141:	74 0d                	je     80102150 <iderw+0x40>
80102143:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102148:	85 c0                	test   %eax,%eax
8010214a:	0f 84 b1 00 00 00    	je     80102201 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102150:	83 ec 0c             	sub    $0xc,%esp
80102153:	68 80 a5 10 80       	push   $0x8010a580
80102158:	e8 03 24 00 00       	call   80104560 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010215d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102163:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102166:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216d:	85 d2                	test   %edx,%edx
8010216f:	75 09                	jne    8010217a <iderw+0x6a>
80102171:	eb 6d                	jmp    801021e0 <iderw+0xd0>
80102173:	90                   	nop
80102174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102178:	89 c2                	mov    %eax,%edx
8010217a:	8b 42 58             	mov    0x58(%edx),%eax
8010217d:	85 c0                	test   %eax,%eax
8010217f:	75 f7                	jne    80102178 <iderw+0x68>
80102181:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102184:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102186:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010218c:	74 42                	je     801021d0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010218e:	8b 03                	mov    (%ebx),%eax
80102190:	83 e0 06             	and    $0x6,%eax
80102193:	83 f8 02             	cmp    $0x2,%eax
80102196:	74 23                	je     801021bb <iderw+0xab>
80102198:	90                   	nop
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021a0:	83 ec 08             	sub    $0x8,%esp
801021a3:	68 80 a5 10 80       	push   $0x8010a580
801021a8:	53                   	push   %ebx
801021a9:	e8 82 1d 00 00       	call   80103f30 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ae:	8b 03                	mov    (%ebx),%eax
801021b0:	83 c4 10             	add    $0x10,%esp
801021b3:	83 e0 06             	and    $0x6,%eax
801021b6:	83 f8 02             	cmp    $0x2,%eax
801021b9:	75 e5                	jne    801021a0 <iderw+0x90>
  }

  release(&idelock);
801021bb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021c5:	c9                   	leave  
  release(&idelock);
801021c6:	e9 55 25 00 00       	jmp    80104720 <release>
801021cb:	90                   	nop
801021cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801021d0:	89 d8                	mov    %ebx,%eax
801021d2:	e8 29 fd ff ff       	call   80101f00 <idestart>
801021d7:	eb b5                	jmp    8010218e <iderw+0x7e>
801021d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021e0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021e5:	eb 9d                	jmp    80102184 <iderw+0x74>
    panic("iderw: nothing to do");
801021e7:	83 ec 0c             	sub    $0xc,%esp
801021ea:	68 0c 74 10 80       	push   $0x8010740c
801021ef:	e8 9c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801021f4:	83 ec 0c             	sub    $0xc,%esp
801021f7:	68 f6 73 10 80       	push   $0x801073f6
801021fc:	e8 8f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102201:	83 ec 0c             	sub    $0xc,%esp
80102204:	68 21 74 10 80       	push   $0x80107421
80102209:	e8 82 e1 ff ff       	call   80100390 <panic>
8010220e:	66 90                	xchg   %ax,%ax

80102210 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
80102210:	a1 84 27 11 80       	mov    0x80112784,%eax
80102215:	85 c0                	test   %eax,%eax
80102217:	0f 84 b3 00 00 00    	je     801022d0 <ioapicinit+0xc0>
{
8010221d:	55                   	push   %ebp
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
8010221e:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
80102225:	00 c0 fe 
{
80102228:	89 e5                	mov    %esp,%ebp
8010222a:	56                   	push   %esi
8010222b:	53                   	push   %ebx
  ioapic->reg = reg;
8010222c:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102233:	00 00 00 
  return ioapic->data;
80102236:	a1 54 26 11 80       	mov    0x80112654,%eax
8010223b:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
8010223e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102244:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010224a:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102251:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102254:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102257:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010225a:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
8010225d:	39 c2                	cmp    %eax,%edx
8010225f:	75 4f                	jne    801022b0 <ioapicinit+0xa0>
80102261:	83 c3 21             	add    $0x21,%ebx
{
80102264:	ba 10 00 00 00       	mov    $0x10,%edx
80102269:	b8 20 00 00 00       	mov    $0x20,%eax
8010226e:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
80102270:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102272:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102278:	89 c6                	mov    %eax,%esi
8010227a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102280:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102283:	89 71 10             	mov    %esi,0x10(%ecx)
80102286:	8d 72 01             	lea    0x1(%edx),%esi
80102289:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010228c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010228e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102290:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102296:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010229d:	75 d1                	jne    80102270 <ioapicinit+0x60>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010229f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022a2:	5b                   	pop    %ebx
801022a3:	5e                   	pop    %esi
801022a4:	5d                   	pop    %ebp
801022a5:	c3                   	ret    
801022a6:	8d 76 00             	lea    0x0(%esi),%esi
801022a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801022b0:	83 ec 0c             	sub    $0xc,%esp
801022b3:	68 40 74 10 80       	push   $0x80107440
801022b8:	e8 a3 e3 ff ff       	call   80100660 <cprintf>
801022bd:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801022c3:	83 c4 10             	add    $0x10,%esp
801022c6:	eb 99                	jmp    80102261 <ioapicinit+0x51>
801022c8:	90                   	nop
801022c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022d0:	f3 c3                	repz ret 
801022d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
801022e0:	8b 15 84 27 11 80    	mov    0x80112784,%edx
{
801022e6:	55                   	push   %ebp
801022e7:	89 e5                	mov    %esp,%ebp
  if(!ismp)
801022e9:	85 d2                	test   %edx,%edx
{
801022eb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
801022ee:	74 2b                	je     8010231b <ioapicenable+0x3b>
  ioapic->reg = reg;
801022f0:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022f6:	8d 50 20             	lea    0x20(%eax),%edx
801022f9:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022fd:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022ff:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102305:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102308:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
8010230e:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102310:	a1 54 26 11 80       	mov    0x80112654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102315:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102318:	89 50 10             	mov    %edx,0x10(%eax)
}
8010231b:	5d                   	pop    %ebp
8010231c:	c3                   	ret    
8010231d:	66 90                	xchg   %ax,%ax
8010231f:	90                   	nop

80102320 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	53                   	push   %ebx
80102324:	83 ec 04             	sub    $0x4,%esp
80102327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010232a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102330:	75 70                	jne    801023a2 <kfree+0x82>
80102332:	81 fb 28 57 11 80    	cmp    $0x80115728,%ebx
80102338:	72 68                	jb     801023a2 <kfree+0x82>
8010233a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102340:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102345:	77 5b                	ja     801023a2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102347:	83 ec 04             	sub    $0x4,%esp
8010234a:	68 00 10 00 00       	push   $0x1000
8010234f:	6a 01                	push   $0x1
80102351:	53                   	push   %ebx
80102352:	e8 19 24 00 00       	call   80104770 <memset>

  if(kmem.use_lock)
80102357:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	85 d2                	test   %edx,%edx
80102362:	75 2c                	jne    80102390 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102364:	a1 98 26 11 80       	mov    0x80112698,%eax
80102369:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010236b:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
80102370:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
80102376:	85 c0                	test   %eax,%eax
80102378:	75 06                	jne    80102380 <kfree+0x60>
    release(&kmem.lock);
}
8010237a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010237d:	c9                   	leave  
8010237e:	c3                   	ret    
8010237f:	90                   	nop
    release(&kmem.lock);
80102380:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
80102387:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238a:	c9                   	leave  
    release(&kmem.lock);
8010238b:	e9 90 23 00 00       	jmp    80104720 <release>
    acquire(&kmem.lock);
80102390:	83 ec 0c             	sub    $0xc,%esp
80102393:	68 60 26 11 80       	push   $0x80112660
80102398:	e8 c3 21 00 00       	call   80104560 <acquire>
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	eb c2                	jmp    80102364 <kfree+0x44>
    panic("kfree");
801023a2:	83 ec 0c             	sub    $0xc,%esp
801023a5:	68 72 74 10 80       	push   $0x80107472
801023aa:	e8 e1 df ff ff       	call   80100390 <panic>
801023af:	90                   	nop

801023b0 <freerange>:
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023cd:	39 de                	cmp    %ebx,%esi
801023cf:	72 23                	jb     801023f4 <freerange+0x44>
801023d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023d8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023de:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023e7:	50                   	push   %eax
801023e8:	e8 33 ff ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023ed:	83 c4 10             	add    $0x10,%esp
801023f0:	39 f3                	cmp    %esi,%ebx
801023f2:	76 e4                	jbe    801023d8 <freerange+0x28>
}
801023f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023f7:	5b                   	pop    %ebx
801023f8:	5e                   	pop    %esi
801023f9:	5d                   	pop    %ebp
801023fa:	c3                   	ret    
801023fb:	90                   	nop
801023fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102400 <kinit1>:
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	56                   	push   %esi
80102404:	53                   	push   %ebx
80102405:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102408:	83 ec 08             	sub    $0x8,%esp
8010240b:	68 78 74 10 80       	push   $0x80107478
80102410:	68 60 26 11 80       	push   $0x80112660
80102415:	e8 26 21 00 00       	call   80104540 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010241a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010241d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102420:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102427:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102430:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102436:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010243c:	39 de                	cmp    %ebx,%esi
8010243e:	72 1c                	jb     8010245c <kinit1+0x5c>
    kfree(p);
80102440:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102446:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102449:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010244f:	50                   	push   %eax
80102450:	e8 cb fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102455:	83 c4 10             	add    $0x10,%esp
80102458:	39 de                	cmp    %ebx,%esi
8010245a:	73 e4                	jae    80102440 <kinit1+0x40>
}
8010245c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010245f:	5b                   	pop    %ebx
80102460:	5e                   	pop    %esi
80102461:	5d                   	pop    %ebp
80102462:	c3                   	ret    
80102463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102470 <kinit2>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102475:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102478:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010247b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102481:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102487:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010248d:	39 de                	cmp    %ebx,%esi
8010248f:	72 23                	jb     801024b4 <kinit2+0x44>
80102491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102498:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010249e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024a7:	50                   	push   %eax
801024a8:	e8 73 fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ad:	83 c4 10             	add    $0x10,%esp
801024b0:	39 de                	cmp    %ebx,%esi
801024b2:	73 e4                	jae    80102498 <kinit2+0x28>
  kmem.use_lock = 1;
801024b4:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801024bb:	00 00 00 
}
801024be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024c1:	5b                   	pop    %ebx
801024c2:	5e                   	pop    %esi
801024c3:	5d                   	pop    %ebp
801024c4:	c3                   	ret    
801024c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024d0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024d0:	a1 94 26 11 80       	mov    0x80112694,%eax
801024d5:	85 c0                	test   %eax,%eax
801024d7:	75 1f                	jne    801024f8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024d9:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
801024de:	85 c0                	test   %eax,%eax
801024e0:	74 0e                	je     801024f0 <kalloc+0x20>
    kmem.freelist = r->next;
801024e2:	8b 10                	mov    (%eax),%edx
801024e4:	89 15 98 26 11 80    	mov    %edx,0x80112698
801024ea:	c3                   	ret    
801024eb:	90                   	nop
801024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801024f0:	f3 c3                	repz ret 
801024f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801024f8:	55                   	push   %ebp
801024f9:	89 e5                	mov    %esp,%ebp
801024fb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801024fe:	68 60 26 11 80       	push   $0x80112660
80102503:	e8 58 20 00 00       	call   80104560 <acquire>
  r = kmem.freelist;
80102508:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
8010250d:	83 c4 10             	add    $0x10,%esp
80102510:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102516:	85 c0                	test   %eax,%eax
80102518:	74 08                	je     80102522 <kalloc+0x52>
    kmem.freelist = r->next;
8010251a:	8b 08                	mov    (%eax),%ecx
8010251c:	89 0d 98 26 11 80    	mov    %ecx,0x80112698
  if(kmem.use_lock)
80102522:	85 d2                	test   %edx,%edx
80102524:	74 16                	je     8010253c <kalloc+0x6c>
    release(&kmem.lock);
80102526:	83 ec 0c             	sub    $0xc,%esp
80102529:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010252c:	68 60 26 11 80       	push   $0x80112660
80102531:	e8 ea 21 00 00       	call   80104720 <release>
  return (char*)r;
80102536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102539:	83 c4 10             	add    $0x10,%esp
}
8010253c:	c9                   	leave  
8010253d:	c3                   	ret    
8010253e:	66 90                	xchg   %ax,%ax

80102540 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102540:	ba 64 00 00 00       	mov    $0x64,%edx
80102545:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102546:	a8 01                	test   $0x1,%al
80102548:	0f 84 c2 00 00 00    	je     80102610 <kbdgetc+0xd0>
8010254e:	ba 60 00 00 00       	mov    $0x60,%edx
80102553:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102554:	0f b6 d0             	movzbl %al,%edx
80102557:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010255d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102563:	0f 84 7f 00 00 00    	je     801025e8 <kbdgetc+0xa8>
{
80102569:	55                   	push   %ebp
8010256a:	89 e5                	mov    %esp,%ebp
8010256c:	53                   	push   %ebx
8010256d:	89 cb                	mov    %ecx,%ebx
8010256f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102572:	84 c0                	test   %al,%al
80102574:	78 4a                	js     801025c0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102576:	85 db                	test   %ebx,%ebx
80102578:	74 09                	je     80102583 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010257a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010257d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102580:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102583:	0f b6 82 a0 75 10 80 	movzbl -0x7fef8a60(%edx),%eax
8010258a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010258c:	0f b6 82 a0 74 10 80 	movzbl -0x7fef8b60(%edx),%eax
80102593:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102595:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102597:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010259d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025a0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a3:	8b 04 85 80 74 10 80 	mov    -0x7fef8b80(,%eax,4),%eax
801025aa:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025ae:	74 31                	je     801025e1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025b0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025b3:	83 fa 19             	cmp    $0x19,%edx
801025b6:	77 40                	ja     801025f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025b8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025bb:	5b                   	pop    %ebx
801025bc:	5d                   	pop    %ebp
801025bd:	c3                   	ret    
801025be:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025c0:	83 e0 7f             	and    $0x7f,%eax
801025c3:	85 db                	test   %ebx,%ebx
801025c5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025c8:	0f b6 82 a0 75 10 80 	movzbl -0x7fef8a60(%edx),%eax
801025cf:	83 c8 40             	or     $0x40,%eax
801025d2:	0f b6 c0             	movzbl %al,%eax
801025d5:	f7 d0                	not    %eax
801025d7:	21 c1                	and    %eax,%ecx
    return 0;
801025d9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025db:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801025e1:	5b                   	pop    %ebx
801025e2:	5d                   	pop    %ebp
801025e3:	c3                   	ret    
801025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025e8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025eb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025ed:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
801025f3:	c3                   	ret    
801025f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801025f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801025fe:	5b                   	pop    %ebx
      c += 'a' - 'A';
801025ff:	83 f9 1a             	cmp    $0x1a,%ecx
80102602:	0f 42 c2             	cmovb  %edx,%eax
}
80102605:	5d                   	pop    %ebp
80102606:	c3                   	ret    
80102607:	89 f6                	mov    %esi,%esi
80102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102610:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102615:	c3                   	ret    
80102616:	8d 76 00             	lea    0x0(%esi),%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102620 <kbdintr>:

void
kbdintr(void)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102626:	68 40 25 10 80       	push   $0x80102540
8010262b:	e8 e0 e1 ff ff       	call   80100810 <consoleintr>
}
80102630:	83 c4 10             	add    $0x10,%esp
80102633:	c9                   	leave  
80102634:	c3                   	ret    
80102635:	66 90                	xchg   %ax,%ax
80102637:	66 90                	xchg   %ax,%ax
80102639:	66 90                	xchg   %ax,%ax
8010263b:	66 90                	xchg   %ax,%ax
8010263d:	66 90                	xchg   %ax,%ax
8010263f:	90                   	nop

80102640 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102640:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
80102645:	55                   	push   %ebp
80102646:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102648:	85 c0                	test   %eax,%eax
8010264a:	0f 84 c8 00 00 00    	je     80102718 <lapicinit+0xd8>
  lapic[index] = value;
80102650:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102657:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010265a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010265d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102664:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102667:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010266a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102671:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102674:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102677:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010267e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102681:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102684:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010268b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102691:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102698:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010269e:	8b 50 30             	mov    0x30(%eax),%edx
801026a1:	c1 ea 10             	shr    $0x10,%edx
801026a4:	80 fa 03             	cmp    $0x3,%dl
801026a7:	77 77                	ja     80102720 <lapicinit+0xe0>
  lapic[index] = value;
801026a9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026da:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026dd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026f1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026f4:	8b 50 20             	mov    0x20(%eax),%edx
801026f7:	89 f6                	mov    %esi,%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102700:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102706:	80 e6 10             	and    $0x10,%dh
80102709:	75 f5                	jne    80102700 <lapicinit+0xc0>
  lapic[index] = value;
8010270b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102712:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102715:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102718:	5d                   	pop    %ebp
80102719:	c3                   	ret    
8010271a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102720:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102727:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx
8010272d:	e9 77 ff ff ff       	jmp    801026a9 <lapicinit+0x69>
80102732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102740 <cpunum>:

int
cpunum(void)
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
80102743:	56                   	push   %esi
80102744:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102745:	9c                   	pushf  
80102746:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102747:	f6 c4 02             	test   $0x2,%ah
8010274a:	74 12                	je     8010275e <cpunum+0x1e>
    static int n;
    if(n++ == 0)
8010274c:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80102751:	8d 50 01             	lea    0x1(%eax),%edx
80102754:	85 c0                	test   %eax,%eax
80102756:	89 15 b8 a5 10 80    	mov    %edx,0x8010a5b8
8010275c:	74 62                	je     801027c0 <cpunum+0x80>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
8010275e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102763:	85 c0                	test   %eax,%eax
80102765:	74 49                	je     801027b0 <cpunum+0x70>
    return 0;

  apicid = lapic[ID] >> 24;
80102767:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
8010276a:	8b 35 80 2d 11 80    	mov    0x80112d80,%esi
  apicid = lapic[ID] >> 24;
80102770:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
80102773:	85 f6                	test   %esi,%esi
80102775:	7e 5e                	jle    801027d5 <cpunum+0x95>
    if (cpus[i].apicid == apicid)
80102777:	0f b6 05 a0 27 11 80 	movzbl 0x801127a0,%eax
8010277e:	39 c3                	cmp    %eax,%ebx
80102780:	74 2e                	je     801027b0 <cpunum+0x70>
80102782:	ba 5c 28 11 80       	mov    $0x8011285c,%edx
  for (i = 0; i < ncpu; ++i) {
80102787:	31 c0                	xor    %eax,%eax
80102789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102790:	83 c0 01             	add    $0x1,%eax
80102793:	39 f0                	cmp    %esi,%eax
80102795:	74 3e                	je     801027d5 <cpunum+0x95>
    if (cpus[i].apicid == apicid)
80102797:	0f b6 0a             	movzbl (%edx),%ecx
8010279a:	81 c2 bc 00 00 00    	add    $0xbc,%edx
801027a0:	39 d9                	cmp    %ebx,%ecx
801027a2:	75 ec                	jne    80102790 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
801027a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027a7:	5b                   	pop    %ebx
801027a8:	5e                   	pop    %esi
801027a9:	5d                   	pop    %ebp
801027aa:	c3                   	ret    
801027ab:	90                   	nop
801027ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
801027b3:	31 c0                	xor    %eax,%eax
}
801027b5:	5b                   	pop    %ebx
801027b6:	5e                   	pop    %esi
801027b7:	5d                   	pop    %ebp
801027b8:	c3                   	ret    
801027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf("cpu called from %x with interrupts enabled\n",
801027c0:	83 ec 08             	sub    $0x8,%esp
801027c3:	ff 75 04             	pushl  0x4(%ebp)
801027c6:	68 a0 76 10 80       	push   $0x801076a0
801027cb:	e8 90 de ff ff       	call   80100660 <cprintf>
801027d0:	83 c4 10             	add    $0x10,%esp
801027d3:	eb 89                	jmp    8010275e <cpunum+0x1e>
  panic("unknown apicid\n");
801027d5:	83 ec 0c             	sub    $0xc,%esp
801027d8:	68 cc 76 10 80       	push   $0x801076cc
801027dd:	e8 ae db ff ff       	call   80100390 <panic>
801027e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027f0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801027f0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
801027f5:	55                   	push   %ebp
801027f6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801027f8:	85 c0                	test   %eax,%eax
801027fa:	74 0d                	je     80102809 <lapiceoi+0x19>
  lapic[index] = value;
801027fc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102803:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102806:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102809:	5d                   	pop    %ebp
8010280a:	c3                   	ret    
8010280b:	90                   	nop
8010280c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102810 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102810:	55                   	push   %ebp
80102811:	89 e5                	mov    %esp,%ebp
}
80102813:	5d                   	pop    %ebp
80102814:	c3                   	ret    
80102815:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102820 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102820:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102821:	b8 0f 00 00 00       	mov    $0xf,%eax
80102826:	ba 70 00 00 00       	mov    $0x70,%edx
8010282b:	89 e5                	mov    %esp,%ebp
8010282d:	53                   	push   %ebx
8010282e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102831:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102834:	ee                   	out    %al,(%dx)
80102835:	b8 0a 00 00 00       	mov    $0xa,%eax
8010283a:	ba 71 00 00 00       	mov    $0x71,%edx
8010283f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102840:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102842:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102845:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010284b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010284d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102850:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102853:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102855:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102858:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010285e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102863:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102869:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010286c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102873:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102876:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102879:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102880:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102883:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102886:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010288c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010288f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102895:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102898:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010289e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028a1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801028aa:	5b                   	pop    %ebx
801028ab:	5d                   	pop    %ebp
801028ac:	c3                   	ret    
801028ad:	8d 76 00             	lea    0x0(%esi),%esi

801028b0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801028b0:	55                   	push   %ebp
801028b1:	b8 0b 00 00 00       	mov    $0xb,%eax
801028b6:	ba 70 00 00 00       	mov    $0x70,%edx
801028bb:	89 e5                	mov    %esp,%ebp
801028bd:	57                   	push   %edi
801028be:	56                   	push   %esi
801028bf:	53                   	push   %ebx
801028c0:	83 ec 4c             	sub    $0x4c,%esp
801028c3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c4:	ba 71 00 00 00       	mov    $0x71,%edx
801028c9:	ec                   	in     (%dx),%al
801028ca:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028cd:	bb 70 00 00 00       	mov    $0x70,%ebx
801028d2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801028d5:	8d 76 00             	lea    0x0(%esi),%esi
801028d8:	31 c0                	xor    %eax,%eax
801028da:	89 da                	mov    %ebx,%edx
801028dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028dd:	b9 71 00 00 00       	mov    $0x71,%ecx
801028e2:	89 ca                	mov    %ecx,%edx
801028e4:	ec                   	in     (%dx),%al
801028e5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e8:	89 da                	mov    %ebx,%edx
801028ea:	b8 02 00 00 00       	mov    $0x2,%eax
801028ef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f0:	89 ca                	mov    %ecx,%edx
801028f2:	ec                   	in     (%dx),%al
801028f3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f6:	89 da                	mov    %ebx,%edx
801028f8:	b8 04 00 00 00       	mov    $0x4,%eax
801028fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fe:	89 ca                	mov    %ecx,%edx
80102900:	ec                   	in     (%dx),%al
80102901:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102904:	89 da                	mov    %ebx,%edx
80102906:	b8 07 00 00 00       	mov    $0x7,%eax
8010290b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290c:	89 ca                	mov    %ecx,%edx
8010290e:	ec                   	in     (%dx),%al
8010290f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102912:	89 da                	mov    %ebx,%edx
80102914:	b8 08 00 00 00       	mov    $0x8,%eax
80102919:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291a:	89 ca                	mov    %ecx,%edx
8010291c:	ec                   	in     (%dx),%al
8010291d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010291f:	89 da                	mov    %ebx,%edx
80102921:	b8 09 00 00 00       	mov    $0x9,%eax
80102926:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102927:	89 ca                	mov    %ecx,%edx
80102929:	ec                   	in     (%dx),%al
8010292a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010292c:	89 da                	mov    %ebx,%edx
8010292e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102933:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102934:	89 ca                	mov    %ecx,%edx
80102936:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102937:	84 c0                	test   %al,%al
80102939:	78 9d                	js     801028d8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010293b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010293f:	89 fa                	mov    %edi,%edx
80102941:	0f b6 fa             	movzbl %dl,%edi
80102944:	89 f2                	mov    %esi,%edx
80102946:	0f b6 f2             	movzbl %dl,%esi
80102949:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010294c:	89 da                	mov    %ebx,%edx
8010294e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102951:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102954:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102958:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010295b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010295f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102962:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102966:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102969:	31 c0                	xor    %eax,%eax
8010296b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296c:	89 ca                	mov    %ecx,%edx
8010296e:	ec                   	in     (%dx),%al
8010296f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102972:	89 da                	mov    %ebx,%edx
80102974:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102977:	b8 02 00 00 00       	mov    $0x2,%eax
8010297c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297d:	89 ca                	mov    %ecx,%edx
8010297f:	ec                   	in     (%dx),%al
80102980:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102983:	89 da                	mov    %ebx,%edx
80102985:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102988:	b8 04 00 00 00       	mov    $0x4,%eax
8010298d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298e:	89 ca                	mov    %ecx,%edx
80102990:	ec                   	in     (%dx),%al
80102991:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102994:	89 da                	mov    %ebx,%edx
80102996:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102999:	b8 07 00 00 00       	mov    $0x7,%eax
8010299e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010299f:	89 ca                	mov    %ecx,%edx
801029a1:	ec                   	in     (%dx),%al
801029a2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a5:	89 da                	mov    %ebx,%edx
801029a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029aa:	b8 08 00 00 00       	mov    $0x8,%eax
801029af:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029b0:	89 ca                	mov    %ecx,%edx
801029b2:	ec                   	in     (%dx),%al
801029b3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b6:	89 da                	mov    %ebx,%edx
801029b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029bb:	b8 09 00 00 00       	mov    $0x9,%eax
801029c0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029c1:	89 ca                	mov    %ecx,%edx
801029c3:	ec                   	in     (%dx),%al
801029c4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029c7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801029ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029cd:	8d 45 d0             	lea    -0x30(%ebp),%eax
801029d0:	6a 18                	push   $0x18
801029d2:	50                   	push   %eax
801029d3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801029d6:	50                   	push   %eax
801029d7:	e8 e4 1d 00 00       	call   801047c0 <memcmp>
801029dc:	83 c4 10             	add    $0x10,%esp
801029df:	85 c0                	test   %eax,%eax
801029e1:	0f 85 f1 fe ff ff    	jne    801028d8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801029e7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
801029eb:	75 78                	jne    80102a65 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801029ed:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029f0:	89 c2                	mov    %eax,%edx
801029f2:	83 e0 0f             	and    $0xf,%eax
801029f5:	c1 ea 04             	shr    $0x4,%edx
801029f8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029fb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029fe:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a01:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a04:	89 c2                	mov    %eax,%edx
80102a06:	83 e0 0f             	and    $0xf,%eax
80102a09:	c1 ea 04             	shr    $0x4,%edx
80102a0c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a0f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a12:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a15:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a18:	89 c2                	mov    %eax,%edx
80102a1a:	83 e0 0f             	and    $0xf,%eax
80102a1d:	c1 ea 04             	shr    $0x4,%edx
80102a20:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a23:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a26:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a29:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a2c:	89 c2                	mov    %eax,%edx
80102a2e:	83 e0 0f             	and    $0xf,%eax
80102a31:	c1 ea 04             	shr    $0x4,%edx
80102a34:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a37:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a3a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a3d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a40:	89 c2                	mov    %eax,%edx
80102a42:	83 e0 0f             	and    $0xf,%eax
80102a45:	c1 ea 04             	shr    $0x4,%edx
80102a48:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a4b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a4e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a51:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a54:	89 c2                	mov    %eax,%edx
80102a56:	83 e0 0f             	and    $0xf,%eax
80102a59:	c1 ea 04             	shr    $0x4,%edx
80102a5c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a5f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a62:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a65:	8b 75 08             	mov    0x8(%ebp),%esi
80102a68:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a6b:	89 06                	mov    %eax,(%esi)
80102a6d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a70:	89 46 04             	mov    %eax,0x4(%esi)
80102a73:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a76:	89 46 08             	mov    %eax,0x8(%esi)
80102a79:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a7c:	89 46 0c             	mov    %eax,0xc(%esi)
80102a7f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a82:	89 46 10             	mov    %eax,0x10(%esi)
80102a85:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a88:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a8b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a92:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a95:	5b                   	pop    %ebx
80102a96:	5e                   	pop    %esi
80102a97:	5f                   	pop    %edi
80102a98:	5d                   	pop    %ebp
80102a99:	c3                   	ret    
80102a9a:	66 90                	xchg   %ax,%ax
80102a9c:	66 90                	xchg   %ax,%ax
80102a9e:	66 90                	xchg   %ax,%ax

80102aa0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102aa0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102aa6:	85 c9                	test   %ecx,%ecx
80102aa8:	0f 8e 8a 00 00 00    	jle    80102b38 <install_trans+0x98>
{
80102aae:	55                   	push   %ebp
80102aaf:	89 e5                	mov    %esp,%ebp
80102ab1:	57                   	push   %edi
80102ab2:	56                   	push   %esi
80102ab3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102ab4:	31 db                	xor    %ebx,%ebx
{
80102ab6:	83 ec 0c             	sub    $0xc,%esp
80102ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ac0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102ac5:	83 ec 08             	sub    $0x8,%esp
80102ac8:	01 d8                	add    %ebx,%eax
80102aca:	83 c0 01             	add    $0x1,%eax
80102acd:	50                   	push   %eax
80102ace:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102ad4:	e8 f7 d5 ff ff       	call   801000d0 <bread>
80102ad9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102adb:	58                   	pop    %eax
80102adc:	5a                   	pop    %edx
80102add:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102ae4:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102aea:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102aed:	e8 de d5 ff ff       	call   801000d0 <bread>
80102af2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102af4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102af7:	83 c4 0c             	add    $0xc,%esp
80102afa:	68 00 02 00 00       	push   $0x200
80102aff:	50                   	push   %eax
80102b00:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b03:	50                   	push   %eax
80102b04:	e8 17 1d 00 00       	call   80104820 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b09:	89 34 24             	mov    %esi,(%esp)
80102b0c:	e8 8f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b11:	89 3c 24             	mov    %edi,(%esp)
80102b14:	e8 c7 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b19:	89 34 24             	mov    %esi,(%esp)
80102b1c:	e8 bf d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b21:	83 c4 10             	add    $0x10,%esp
80102b24:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102b2a:	7f 94                	jg     80102ac0 <install_trans+0x20>
  }
}
80102b2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b2f:	5b                   	pop    %ebx
80102b30:	5e                   	pop    %esi
80102b31:	5f                   	pop    %edi
80102b32:	5d                   	pop    %ebp
80102b33:	c3                   	ret    
80102b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b38:	f3 c3                	repz ret 
80102b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b40 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b40:	55                   	push   %ebp
80102b41:	89 e5                	mov    %esp,%ebp
80102b43:	56                   	push   %esi
80102b44:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102b45:	83 ec 08             	sub    $0x8,%esp
80102b48:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102b4e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102b54:	e8 77 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b59:	8b 1d e8 26 11 80    	mov    0x801126e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b5f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b62:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102b64:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102b66:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b69:	7e 16                	jle    80102b81 <write_head+0x41>
80102b6b:	c1 e3 02             	shl    $0x2,%ebx
80102b6e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102b70:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102b76:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102b7a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102b7d:	39 da                	cmp    %ebx,%edx
80102b7f:	75 ef                	jne    80102b70 <write_head+0x30>
  }
  bwrite(buf);
80102b81:	83 ec 0c             	sub    $0xc,%esp
80102b84:	56                   	push   %esi
80102b85:	e8 16 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b8a:	89 34 24             	mov    %esi,(%esp)
80102b8d:	e8 4e d6 ff ff       	call   801001e0 <brelse>
}
80102b92:	83 c4 10             	add    $0x10,%esp
80102b95:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b98:	5b                   	pop    %ebx
80102b99:	5e                   	pop    %esi
80102b9a:	5d                   	pop    %ebp
80102b9b:	c3                   	ret    
80102b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ba0 <initlog>:
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	53                   	push   %ebx
80102ba4:	83 ec 2c             	sub    $0x2c,%esp
80102ba7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102baa:	68 dc 76 10 80       	push   $0x801076dc
80102baf:	68 a0 26 11 80       	push   $0x801126a0
80102bb4:	e8 87 19 00 00       	call   80104540 <initlock>
  readsb(dev, &sb);
80102bb9:	58                   	pop    %eax
80102bba:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bbd:	5a                   	pop    %edx
80102bbe:	50                   	push   %eax
80102bbf:	53                   	push   %ebx
80102bc0:	e8 fb e7 ff ff       	call   801013c0 <readsb>
  log.size = sb.nlog;
80102bc5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102bc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102bcb:	59                   	pop    %ecx
  log.dev = dev;
80102bcc:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102bd2:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  log.start = sb.logstart;
80102bd8:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  struct buf *buf = bread(log.dev, log.start);
80102bdd:	5a                   	pop    %edx
80102bde:	50                   	push   %eax
80102bdf:	53                   	push   %ebx
80102be0:	e8 eb d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102be5:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102be8:	83 c4 10             	add    $0x10,%esp
80102beb:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102bed:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102bf3:	7e 1c                	jle    80102c11 <initlog+0x71>
80102bf5:	c1 e3 02             	shl    $0x2,%ebx
80102bf8:	31 d2                	xor    %edx,%edx
80102bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102c00:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c04:	83 c2 04             	add    $0x4,%edx
80102c07:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c0d:	39 d3                	cmp    %edx,%ebx
80102c0f:	75 ef                	jne    80102c00 <initlog+0x60>
  brelse(buf);
80102c11:	83 ec 0c             	sub    $0xc,%esp
80102c14:	50                   	push   %eax
80102c15:	e8 c6 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c1a:	e8 81 fe ff ff       	call   80102aa0 <install_trans>
  log.lh.n = 0;
80102c1f:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102c26:	00 00 00 
  write_head(); // clear the log
80102c29:	e8 12 ff ff ff       	call   80102b40 <write_head>
}
80102c2e:	83 c4 10             	add    $0x10,%esp
80102c31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c34:	c9                   	leave  
80102c35:	c3                   	ret    
80102c36:	8d 76 00             	lea    0x0(%esi),%esi
80102c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c46:	68 a0 26 11 80       	push   $0x801126a0
80102c4b:	e8 10 19 00 00       	call   80104560 <acquire>
80102c50:	83 c4 10             	add    $0x10,%esp
80102c53:	eb 18                	jmp    80102c6d <begin_op+0x2d>
80102c55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c58:	83 ec 08             	sub    $0x8,%esp
80102c5b:	68 a0 26 11 80       	push   $0x801126a0
80102c60:	68 a0 26 11 80       	push   $0x801126a0
80102c65:	e8 c6 12 00 00       	call   80103f30 <sleep>
80102c6a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102c6d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102c72:	85 c0                	test   %eax,%eax
80102c74:	75 e2                	jne    80102c58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c76:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102c7b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102c81:	83 c0 01             	add    $0x1,%eax
80102c84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c8a:	83 fa 1e             	cmp    $0x1e,%edx
80102c8d:	7f c9                	jg     80102c58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c8f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c92:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102c97:	68 a0 26 11 80       	push   $0x801126a0
80102c9c:	e8 7f 1a 00 00       	call   80104720 <release>
      break;
    }
  }
}
80102ca1:	83 c4 10             	add    $0x10,%esp
80102ca4:	c9                   	leave  
80102ca5:	c3                   	ret    
80102ca6:	8d 76 00             	lea    0x0(%esi),%esi
80102ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	57                   	push   %edi
80102cb4:	56                   	push   %esi
80102cb5:	53                   	push   %ebx
80102cb6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102cb9:	68 a0 26 11 80       	push   $0x801126a0
80102cbe:	e8 9d 18 00 00       	call   80104560 <acquire>
  log.outstanding -= 1;
80102cc3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102cc8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102cce:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102cd1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102cd4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102cd6:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102cdc:	0f 85 1a 01 00 00    	jne    80102dfc <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102ce2:	85 db                	test   %ebx,%ebx
80102ce4:	0f 85 ee 00 00 00    	jne    80102dd8 <end_op+0x128>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102cea:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102ced:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102cf4:	00 00 00 
  release(&log.lock);
80102cf7:	68 a0 26 11 80       	push   $0x801126a0
80102cfc:	e8 1f 1a 00 00       	call   80104720 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d01:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102d07:	83 c4 10             	add    $0x10,%esp
80102d0a:	85 c9                	test   %ecx,%ecx
80102d0c:	0f 8e 85 00 00 00    	jle    80102d97 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d12:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102d17:	83 ec 08             	sub    $0x8,%esp
80102d1a:	01 d8                	add    %ebx,%eax
80102d1c:	83 c0 01             	add    $0x1,%eax
80102d1f:	50                   	push   %eax
80102d20:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102d26:	e8 a5 d3 ff ff       	call   801000d0 <bread>
80102d2b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d2d:	58                   	pop    %eax
80102d2e:	5a                   	pop    %edx
80102d2f:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102d36:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d3c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d3f:	e8 8c d3 ff ff       	call   801000d0 <bread>
80102d44:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d46:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d49:	83 c4 0c             	add    $0xc,%esp
80102d4c:	68 00 02 00 00       	push   $0x200
80102d51:	50                   	push   %eax
80102d52:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d55:	50                   	push   %eax
80102d56:	e8 c5 1a 00 00       	call   80104820 <memmove>
    bwrite(to);  // write the log
80102d5b:	89 34 24             	mov    %esi,(%esp)
80102d5e:	e8 3d d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d63:	89 3c 24             	mov    %edi,(%esp)
80102d66:	e8 75 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d6b:	89 34 24             	mov    %esi,(%esp)
80102d6e:	e8 6d d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d73:	83 c4 10             	add    $0x10,%esp
80102d76:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102d7c:	7c 94                	jl     80102d12 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d7e:	e8 bd fd ff ff       	call   80102b40 <write_head>
    install_trans(); // Now install writes to home locations
80102d83:	e8 18 fd ff ff       	call   80102aa0 <install_trans>
    log.lh.n = 0;
80102d88:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d8f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d92:	e8 a9 fd ff ff       	call   80102b40 <write_head>
    acquire(&log.lock);
80102d97:	83 ec 0c             	sub    $0xc,%esp
80102d9a:	68 a0 26 11 80       	push   $0x801126a0
80102d9f:	e8 bc 17 00 00       	call   80104560 <acquire>
    wakeup(&log);
80102da4:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102dab:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102db2:	00 00 00 
    wakeup(&log);
80102db5:	e8 26 13 00 00       	call   801040e0 <wakeup>
    release(&log.lock);
80102dba:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dc1:	e8 5a 19 00 00       	call   80104720 <release>
80102dc6:	83 c4 10             	add    $0x10,%esp
}
80102dc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dcc:	5b                   	pop    %ebx
80102dcd:	5e                   	pop    %esi
80102dce:	5f                   	pop    %edi
80102dcf:	5d                   	pop    %ebp
80102dd0:	c3                   	ret    
80102dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102dd8:	83 ec 0c             	sub    $0xc,%esp
80102ddb:	68 a0 26 11 80       	push   $0x801126a0
80102de0:	e8 fb 12 00 00       	call   801040e0 <wakeup>
  release(&log.lock);
80102de5:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dec:	e8 2f 19 00 00       	call   80104720 <release>
80102df1:	83 c4 10             	add    $0x10,%esp
}
80102df4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102df7:	5b                   	pop    %ebx
80102df8:	5e                   	pop    %esi
80102df9:	5f                   	pop    %edi
80102dfa:	5d                   	pop    %ebp
80102dfb:	c3                   	ret    
    panic("log.committing");
80102dfc:	83 ec 0c             	sub    $0xc,%esp
80102dff:	68 e0 76 10 80       	push   $0x801076e0
80102e04:	e8 87 d5 ff ff       	call   80100390 <panic>
80102e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e10 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	53                   	push   %ebx
80102e14:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e17:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102e1d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e20:	83 fa 1d             	cmp    $0x1d,%edx
80102e23:	0f 8f 9d 00 00 00    	jg     80102ec6 <log_write+0xb6>
80102e29:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102e2e:	83 e8 01             	sub    $0x1,%eax
80102e31:	39 c2                	cmp    %eax,%edx
80102e33:	0f 8d 8d 00 00 00    	jge    80102ec6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e39:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102e3e:	85 c0                	test   %eax,%eax
80102e40:	0f 8e 8d 00 00 00    	jle    80102ed3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e46:	83 ec 0c             	sub    $0xc,%esp
80102e49:	68 a0 26 11 80       	push   $0x801126a0
80102e4e:	e8 0d 17 00 00       	call   80104560 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e53:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e59:	83 c4 10             	add    $0x10,%esp
80102e5c:	83 f9 00             	cmp    $0x0,%ecx
80102e5f:	7e 57                	jle    80102eb8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e61:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e64:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e66:	3b 15 ec 26 11 80    	cmp    0x801126ec,%edx
80102e6c:	75 0b                	jne    80102e79 <log_write+0x69>
80102e6e:	eb 38                	jmp    80102ea8 <log_write+0x98>
80102e70:	39 14 85 ec 26 11 80 	cmp    %edx,-0x7feed914(,%eax,4)
80102e77:	74 2f                	je     80102ea8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102e79:	83 c0 01             	add    $0x1,%eax
80102e7c:	39 c1                	cmp    %eax,%ecx
80102e7e:	75 f0                	jne    80102e70 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e80:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e87:	83 c0 01             	add    $0x1,%eax
80102e8a:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102e8f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e92:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102e99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e9c:	c9                   	leave  
  release(&log.lock);
80102e9d:	e9 7e 18 00 00       	jmp    80104720 <release>
80102ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ea8:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
80102eaf:	eb de                	jmp    80102e8f <log_write+0x7f>
80102eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eb8:	8b 43 08             	mov    0x8(%ebx),%eax
80102ebb:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102ec0:	75 cd                	jne    80102e8f <log_write+0x7f>
80102ec2:	31 c0                	xor    %eax,%eax
80102ec4:	eb c1                	jmp    80102e87 <log_write+0x77>
    panic("too big a transaction");
80102ec6:	83 ec 0c             	sub    $0xc,%esp
80102ec9:	68 ef 76 10 80       	push   $0x801076ef
80102ece:	e8 bd d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102ed3:	83 ec 0c             	sub    $0xc,%esp
80102ed6:	68 05 77 10 80       	push   $0x80107705
80102edb:	e8 b0 d4 ff ff       	call   80100390 <panic>

80102ee0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102ee6:	e8 55 f8 ff ff       	call   80102740 <cpunum>
80102eeb:	83 ec 08             	sub    $0x8,%esp
80102eee:	50                   	push   %eax
80102eef:	68 20 77 10 80       	push   $0x80107720
80102ef4:	e8 67 d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102ef9:	e8 b2 2b 00 00       	call   80105ab0 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102efe:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f05:	b8 01 00 00 00       	mov    $0x1,%eax
80102f0a:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102f11:	e8 ba 0c 00 00       	call   80103bd0 <scheduler>
80102f16:	8d 76 00             	lea    0x0(%esi),%esi
80102f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f20 <mpenter>:
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f26:	e8 15 3d 00 00       	call   80106c40 <switchkvm>
  seginit();
80102f2b:	e8 a0 3b 00 00       	call   80106ad0 <seginit>
  lapicinit();
80102f30:	e8 0b f7 ff ff       	call   80102640 <lapicinit>
  mpmain();
80102f35:	e8 a6 ff ff ff       	call   80102ee0 <mpmain>
80102f3a:	66 90                	xchg   %ax,%ax
80102f3c:	66 90                	xchg   %ax,%ax
80102f3e:	66 90                	xchg   %ax,%ax

80102f40 <main>:
{
80102f40:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f44:	83 e4 f0             	and    $0xfffffff0,%esp
80102f47:	ff 71 fc             	pushl  -0x4(%ecx)
80102f4a:	55                   	push   %ebp
80102f4b:	89 e5                	mov    %esp,%ebp
80102f4d:	53                   	push   %ebx
80102f4e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f4f:	83 ec 08             	sub    $0x8,%esp
80102f52:	68 00 00 40 80       	push   $0x80400000
80102f57:	68 28 57 11 80       	push   $0x80115728
80102f5c:	e8 9f f4 ff ff       	call   80102400 <kinit1>
  kvmalloc();      // kernel page table
80102f61:	e8 ba 3c 00 00       	call   80106c20 <kvmalloc>
  mpinit();        // detect other processors
80102f66:	e8 b5 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102f6b:	e8 d0 f6 ff ff       	call   80102640 <lapicinit>
  seginit();       // segment descriptors
80102f70:	e8 5b 3b 00 00       	call   80106ad0 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f75:	e8 c6 f7 ff ff       	call   80102740 <cpunum>
80102f7a:	5a                   	pop    %edx
80102f7b:	59                   	pop    %ecx
80102f7c:	50                   	push   %eax
80102f7d:	68 31 77 10 80       	push   $0x80107731
80102f82:	e8 d9 d6 ff ff       	call   80100660 <cprintf>
  picinit();       // another interrupt controller
80102f87:	e8 b4 03 00 00       	call   80103340 <picinit>
  ioapicinit();    // another interrupt controller
80102f8c:	e8 7f f2 ff ff       	call   80102210 <ioapicinit>
  consoleinit();   // console hardware
80102f91:	e8 2a da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f96:	e8 05 2e 00 00       	call   80105da0 <uartinit>
  pinit();         // process table
80102f9b:	e8 80 09 00 00       	call   80103920 <pinit>
  tvinit();        // trap vectors
80102fa0:	e8 8b 2a 00 00       	call   80105a30 <tvinit>
  binit();         // buffer cache
80102fa5:	e8 96 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102faa:	e8 a1 dd ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk
80102faf:	e8 2c f0 ff ff       	call   80101fe0 <ideinit>
  if(!ismp)
80102fb4:	8b 1d 84 27 11 80    	mov    0x80112784,%ebx
80102fba:	83 c4 10             	add    $0x10,%esp
80102fbd:	85 db                	test   %ebx,%ebx
80102fbf:	0f 84 ca 00 00 00    	je     8010308f <main+0x14f>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fc5:	83 ec 04             	sub    $0x4,%esp
80102fc8:	68 8a 00 00 00       	push   $0x8a
80102fcd:	68 8c a4 10 80       	push   $0x8010a48c
80102fd2:	68 00 70 00 80       	push   $0x80007000
80102fd7:	e8 44 18 00 00       	call   80104820 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fdc:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102fe3:	00 00 00 
80102fe6:	83 c4 10             	add    $0x10,%esp
80102fe9:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fee:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80102ff3:	76 7e                	jbe    80103073 <main+0x133>
80102ff5:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80102ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(c == cpus+cpunum())  // We've started already.
80103000:	e8 3b f7 ff ff       	call   80102740 <cpunum>
80103005:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010300b:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103010:	39 c3                	cmp    %eax,%ebx
80103012:	74 46                	je     8010305a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103014:	e8 b7 f4 ff ff       	call   801024d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103019:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-4) = stack + KSTACKSIZE;
8010301c:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80103021:	c7 05 f8 6f 00 80 20 	movl   $0x80102f20,0x80006ff8
80103028:	2f 10 80 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010302b:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103030:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80103037:	90 10 00 
    lapicstartap(c->apicid, V2P(code));
8010303a:	68 00 70 00 00       	push   $0x7000
8010303f:	0f b6 03             	movzbl (%ebx),%eax
80103042:	50                   	push   %eax
80103043:	e8 d8 f7 ff ff       	call   80102820 <lapicstartap>
80103048:	83 c4 10             	add    $0x10,%esp
8010304b:	90                   	nop
8010304c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103050:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80103056:	85 c0                	test   %eax,%eax
80103058:	74 f6                	je     80103050 <main+0x110>
  for(c = cpus; c < cpus+ncpu; c++){
8010305a:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80103061:	00 00 00 
80103064:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
8010306a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010306f:	39 c3                	cmp    %eax,%ebx
80103071:	72 8d                	jb     80103000 <main+0xc0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103073:	83 ec 08             	sub    $0x8,%esp
80103076:	68 00 00 00 8e       	push   $0x8e000000
8010307b:	68 00 00 40 80       	push   $0x80400000
80103080:	e8 eb f3 ff ff       	call   80102470 <kinit2>
  userinit();      // first user process
80103085:	e8 b6 08 00 00       	call   80103940 <userinit>
  mpmain();        // finish this processor's setup
8010308a:	e8 51 fe ff ff       	call   80102ee0 <mpmain>
    timerinit();   // uniprocessor timer
8010308f:	e8 3c 29 00 00       	call   801059d0 <timerinit>
80103094:	e9 2c ff ff ff       	jmp    80102fc5 <main+0x85>
80103099:	66 90                	xchg   %ax,%ax
8010309b:	66 90                	xchg   %ax,%ax
8010309d:	66 90                	xchg   %ax,%ax
8010309f:	90                   	nop

801030a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	57                   	push   %edi
801030a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801030ab:	53                   	push   %ebx
  e = addr+len;
801030ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801030af:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801030b2:	39 de                	cmp    %ebx,%esi
801030b4:	72 10                	jb     801030c6 <mpsearch1+0x26>
801030b6:	eb 50                	jmp    80103108 <mpsearch1+0x68>
801030b8:	90                   	nop
801030b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030c0:	39 fb                	cmp    %edi,%ebx
801030c2:	89 fe                	mov    %edi,%esi
801030c4:	76 42                	jbe    80103108 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030c6:	83 ec 04             	sub    $0x4,%esp
801030c9:	8d 7e 10             	lea    0x10(%esi),%edi
801030cc:	6a 04                	push   $0x4
801030ce:	68 48 77 10 80       	push   $0x80107748
801030d3:	56                   	push   %esi
801030d4:	e8 e7 16 00 00       	call   801047c0 <memcmp>
801030d9:	83 c4 10             	add    $0x10,%esp
801030dc:	85 c0                	test   %eax,%eax
801030de:	75 e0                	jne    801030c0 <mpsearch1+0x20>
801030e0:	89 f1                	mov    %esi,%ecx
801030e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801030e8:	0f b6 11             	movzbl (%ecx),%edx
801030eb:	83 c1 01             	add    $0x1,%ecx
801030ee:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801030f0:	39 f9                	cmp    %edi,%ecx
801030f2:	75 f4                	jne    801030e8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030f4:	84 c0                	test   %al,%al
801030f6:	75 c8                	jne    801030c0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801030f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030fb:	89 f0                	mov    %esi,%eax
801030fd:	5b                   	pop    %ebx
801030fe:	5e                   	pop    %esi
801030ff:	5f                   	pop    %edi
80103100:	5d                   	pop    %ebp
80103101:	c3                   	ret    
80103102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103108:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010310b:	31 f6                	xor    %esi,%esi
}
8010310d:	89 f0                	mov    %esi,%eax
8010310f:	5b                   	pop    %ebx
80103110:	5e                   	pop    %esi
80103111:	5f                   	pop    %edi
80103112:	5d                   	pop    %ebp
80103113:	c3                   	ret    
80103114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010311a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103120 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	57                   	push   %edi
80103124:	56                   	push   %esi
80103125:	53                   	push   %ebx
80103126:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103129:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103130:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103137:	c1 e0 08             	shl    $0x8,%eax
8010313a:	09 d0                	or     %edx,%eax
8010313c:	c1 e0 04             	shl    $0x4,%eax
8010313f:	85 c0                	test   %eax,%eax
80103141:	75 1b                	jne    8010315e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103143:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010314a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103151:	c1 e0 08             	shl    $0x8,%eax
80103154:	09 d0                	or     %edx,%eax
80103156:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103159:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010315e:	ba 00 04 00 00       	mov    $0x400,%edx
80103163:	e8 38 ff ff ff       	call   801030a0 <mpsearch1>
80103168:	85 c0                	test   %eax,%eax
8010316a:	89 c7                	mov    %eax,%edi
8010316c:	0f 84 76 01 00 00    	je     801032e8 <mpinit+0x1c8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103172:	8b 5f 04             	mov    0x4(%edi),%ebx
80103175:	85 db                	test   %ebx,%ebx
80103177:	0f 84 e6 00 00 00    	je     80103263 <mpinit+0x143>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010317d:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103183:	83 ec 04             	sub    $0x4,%esp
80103186:	6a 04                	push   $0x4
80103188:	68 4d 77 10 80       	push   $0x8010774d
8010318d:	56                   	push   %esi
8010318e:	e8 2d 16 00 00       	call   801047c0 <memcmp>
80103193:	83 c4 10             	add    $0x10,%esp
80103196:	85 c0                	test   %eax,%eax
80103198:	0f 85 c5 00 00 00    	jne    80103263 <mpinit+0x143>
  if(conf->version != 1 && conf->version != 4)
8010319e:	0f b6 93 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%edx
801031a5:	80 fa 01             	cmp    $0x1,%dl
801031a8:	0f 95 c1             	setne  %cl
801031ab:	80 fa 04             	cmp    $0x4,%dl
801031ae:	0f 95 c2             	setne  %dl
801031b1:	20 ca                	and    %cl,%dl
801031b3:	0f 85 aa 00 00 00    	jne    80103263 <mpinit+0x143>
  if(sum((uchar*)conf, conf->length) != 0)
801031b9:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
  for(i=0; i<len; i++)
801031c0:	66 85 c9             	test   %cx,%cx
801031c3:	74 1f                	je     801031e4 <mpinit+0xc4>
801031c5:	01 f1                	add    %esi,%ecx
801031c7:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801031ca:	89 f2                	mov    %esi,%edx
801031cc:	89 cb                	mov    %ecx,%ebx
801031ce:	66 90                	xchg   %ax,%ax
    sum += addr[i];
801031d0:	0f b6 0a             	movzbl (%edx),%ecx
801031d3:	83 c2 01             	add    $0x1,%edx
801031d6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031d8:	39 da                	cmp    %ebx,%edx
801031da:	75 f4                	jne    801031d0 <mpinit+0xb0>
801031dc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801031df:	84 c0                	test   %al,%al
801031e1:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031e4:	85 f6                	test   %esi,%esi
801031e6:	74 7b                	je     80103263 <mpinit+0x143>
801031e8:	84 d2                	test   %dl,%dl
801031ea:	75 77                	jne    80103263 <mpinit+0x143>
    return;
  ismp = 1;
801031ec:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
801031f3:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801031f6:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031fc:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103201:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103208:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
8010320e:	01 d6                	add    %edx,%esi
80103210:	39 f0                	cmp    %esi,%eax
80103212:	0f 83 a8 00 00 00    	jae    801032c0 <mpinit+0x1a0>
80103218:	90                   	nop
80103219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103220:	80 38 04             	cmpb   $0x4,(%eax)
80103223:	0f 87 87 00 00 00    	ja     801032b0 <mpinit+0x190>
80103229:	0f b6 10             	movzbl (%eax),%edx
8010322c:	ff 24 95 54 77 10 80 	jmp    *-0x7fef88ac(,%edx,4)
80103233:	90                   	nop
80103234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103238:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010323b:	39 c6                	cmp    %eax,%esi
8010323d:	77 e1                	ja     80103220 <mpinit+0x100>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010323f:	a1 84 27 11 80       	mov    0x80112784,%eax
80103244:	85 c0                	test   %eax,%eax
80103246:	75 78                	jne    801032c0 <mpinit+0x1a0>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103248:	c7 05 80 2d 11 80 01 	movl   $0x1,0x80112d80
8010324f:	00 00 00 
    lapic = 0;
80103252:	c7 05 9c 26 11 80 00 	movl   $0x0,0x8011269c
80103259:	00 00 00 
    ioapicid = 0;
8010325c:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103263:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103266:	5b                   	pop    %ebx
80103267:	5e                   	pop    %esi
80103268:	5f                   	pop    %edi
80103269:	5d                   	pop    %ebp
8010326a:	c3                   	ret    
8010326b:	90                   	nop
8010326c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103270:	8b 15 80 2d 11 80    	mov    0x80112d80,%edx
80103276:	83 fa 07             	cmp    $0x7,%edx
80103279:	7f 19                	jg     80103294 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010327b:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
8010327f:	69 da bc 00 00 00    	imul   $0xbc,%edx,%ebx
        ncpu++;
80103285:	83 c2 01             	add    $0x1,%edx
80103288:	89 15 80 2d 11 80    	mov    %edx,0x80112d80
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010328e:	88 8b a0 27 11 80    	mov    %cl,-0x7feed860(%ebx)
      p += sizeof(struct mpproc);
80103294:	83 c0 14             	add    $0x14,%eax
      continue;
80103297:	eb a2                	jmp    8010323b <mpinit+0x11b>
80103299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801032a0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801032a4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801032a7:	88 15 80 27 11 80    	mov    %dl,0x80112780
      continue;
801032ad:	eb 8c                	jmp    8010323b <mpinit+0x11b>
801032af:	90                   	nop
      ismp = 0;
801032b0:	c7 05 84 27 11 80 00 	movl   $0x0,0x80112784
801032b7:	00 00 00 
      break;
801032ba:	e9 7c ff ff ff       	jmp    8010323b <mpinit+0x11b>
801032bf:	90                   	nop
  if(mp->imcrp){
801032c0:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801032c4:	74 9d                	je     80103263 <mpinit+0x143>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032c6:	b8 70 00 00 00       	mov    $0x70,%eax
801032cb:	ba 22 00 00 00       	mov    $0x22,%edx
801032d0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032d1:	ba 23 00 00 00       	mov    $0x23,%edx
801032d6:	ec                   	in     (%dx),%al
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032d7:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032da:	ee                   	out    %al,(%dx)
}
801032db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032de:	5b                   	pop    %ebx
801032df:	5e                   	pop    %esi
801032e0:	5f                   	pop    %edi
801032e1:	5d                   	pop    %ebp
801032e2:	c3                   	ret    
801032e3:	90                   	nop
801032e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
801032e8:	ba 00 00 01 00       	mov    $0x10000,%edx
801032ed:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032f2:	e8 a9 fd ff ff       	call   801030a0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032f7:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801032f9:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032fb:	0f 85 71 fe ff ff    	jne    80103172 <mpinit+0x52>
80103301:	e9 5d ff ff ff       	jmp    80103263 <mpinit+0x143>
80103306:	66 90                	xchg   %ax,%ax
80103308:	66 90                	xchg   %ax,%ax
8010330a:	66 90                	xchg   %ax,%ax
8010330c:	66 90                	xchg   %ax,%ax
8010330e:	66 90                	xchg   %ax,%ax

80103310 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103310:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103311:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103316:	ba 21 00 00 00       	mov    $0x21,%edx
{
8010331b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010331d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103320:	d3 c0                	rol    %cl,%eax
80103322:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
  irqmask = mask;
80103329:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
8010332f:	ee                   	out    %al,(%dx)
80103330:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC2+1, mask >> 8);
80103335:	66 c1 e8 08          	shr    $0x8,%ax
80103339:	ee                   	out    %al,(%dx)
}
8010333a:	5d                   	pop    %ebp
8010333b:	c3                   	ret    
8010333c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103340 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103340:	55                   	push   %ebp
80103341:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103346:	89 e5                	mov    %esp,%ebp
80103348:	57                   	push   %edi
80103349:	56                   	push   %esi
8010334a:	53                   	push   %ebx
8010334b:	bb 21 00 00 00       	mov    $0x21,%ebx
80103350:	89 da                	mov    %ebx,%edx
80103352:	ee                   	out    %al,(%dx)
80103353:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80103358:	89 ca                	mov    %ecx,%edx
8010335a:	ee                   	out    %al,(%dx)
8010335b:	be 11 00 00 00       	mov    $0x11,%esi
80103360:	ba 20 00 00 00       	mov    $0x20,%edx
80103365:	89 f0                	mov    %esi,%eax
80103367:	ee                   	out    %al,(%dx)
80103368:	b8 20 00 00 00       	mov    $0x20,%eax
8010336d:	89 da                	mov    %ebx,%edx
8010336f:	ee                   	out    %al,(%dx)
80103370:	b8 04 00 00 00       	mov    $0x4,%eax
80103375:	ee                   	out    %al,(%dx)
80103376:	bf 03 00 00 00       	mov    $0x3,%edi
8010337b:	89 f8                	mov    %edi,%eax
8010337d:	ee                   	out    %al,(%dx)
8010337e:	ba a0 00 00 00       	mov    $0xa0,%edx
80103383:	89 f0                	mov    %esi,%eax
80103385:	ee                   	out    %al,(%dx)
80103386:	b8 28 00 00 00       	mov    $0x28,%eax
8010338b:	89 ca                	mov    %ecx,%edx
8010338d:	ee                   	out    %al,(%dx)
8010338e:	b8 02 00 00 00       	mov    $0x2,%eax
80103393:	ee                   	out    %al,(%dx)
80103394:	89 f8                	mov    %edi,%eax
80103396:	ee                   	out    %al,(%dx)
80103397:	bf 68 00 00 00       	mov    $0x68,%edi
8010339c:	ba 20 00 00 00       	mov    $0x20,%edx
801033a1:	89 f8                	mov    %edi,%eax
801033a3:	ee                   	out    %al,(%dx)
801033a4:	be 0a 00 00 00       	mov    $0xa,%esi
801033a9:	89 f0                	mov    %esi,%eax
801033ab:	ee                   	out    %al,(%dx)
801033ac:	ba a0 00 00 00       	mov    $0xa0,%edx
801033b1:	89 f8                	mov    %edi,%eax
801033b3:	ee                   	out    %al,(%dx)
801033b4:	89 f0                	mov    %esi,%eax
801033b6:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
801033b7:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
801033be:	66 83 f8 ff          	cmp    $0xffff,%ax
801033c2:	74 0a                	je     801033ce <picinit+0x8e>
801033c4:	89 da                	mov    %ebx,%edx
801033c6:	ee                   	out    %al,(%dx)
  outb(IO_PIC2+1, mask >> 8);
801033c7:	66 c1 e8 08          	shr    $0x8,%ax
801033cb:	89 ca                	mov    %ecx,%edx
801033cd:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
801033ce:	5b                   	pop    %ebx
801033cf:	5e                   	pop    %esi
801033d0:	5f                   	pop    %edi
801033d1:	5d                   	pop    %ebp
801033d2:	c3                   	ret    
801033d3:	66 90                	xchg   %ax,%ax
801033d5:	66 90                	xchg   %ax,%ax
801033d7:	66 90                	xchg   %ax,%ax
801033d9:	66 90                	xchg   %ax,%ax
801033db:	66 90                	xchg   %ax,%ax
801033dd:	66 90                	xchg   %ax,%ax
801033df:	90                   	nop

801033e0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 0c             	sub    $0xc,%esp
801033e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ef:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033f5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033fb:	e8 70 d9 ff ff       	call   80100d70 <filealloc>
80103400:	85 c0                	test   %eax,%eax
80103402:	89 03                	mov    %eax,(%ebx)
80103404:	74 22                	je     80103428 <pipealloc+0x48>
80103406:	e8 65 d9 ff ff       	call   80100d70 <filealloc>
8010340b:	85 c0                	test   %eax,%eax
8010340d:	89 06                	mov    %eax,(%esi)
8010340f:	74 3f                	je     80103450 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103411:	e8 ba f0 ff ff       	call   801024d0 <kalloc>
80103416:	85 c0                	test   %eax,%eax
80103418:	89 c7                	mov    %eax,%edi
8010341a:	75 54                	jne    80103470 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010341c:	8b 03                	mov    (%ebx),%eax
8010341e:	85 c0                	test   %eax,%eax
80103420:	75 34                	jne    80103456 <pipealloc+0x76>
80103422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103428:	8b 06                	mov    (%esi),%eax
8010342a:	85 c0                	test   %eax,%eax
8010342c:	74 0c                	je     8010343a <pipealloc+0x5a>
    fileclose(*f1);
8010342e:	83 ec 0c             	sub    $0xc,%esp
80103431:	50                   	push   %eax
80103432:	e8 f9 d9 ff ff       	call   80100e30 <fileclose>
80103437:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010343a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010343d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103442:	5b                   	pop    %ebx
80103443:	5e                   	pop    %esi
80103444:	5f                   	pop    %edi
80103445:	5d                   	pop    %ebp
80103446:	c3                   	ret    
80103447:	89 f6                	mov    %esi,%esi
80103449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103450:	8b 03                	mov    (%ebx),%eax
80103452:	85 c0                	test   %eax,%eax
80103454:	74 e4                	je     8010343a <pipealloc+0x5a>
    fileclose(*f0);
80103456:	83 ec 0c             	sub    $0xc,%esp
80103459:	50                   	push   %eax
8010345a:	e8 d1 d9 ff ff       	call   80100e30 <fileclose>
  if(*f1)
8010345f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103461:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103464:	85 c0                	test   %eax,%eax
80103466:	75 c6                	jne    8010342e <pipealloc+0x4e>
80103468:	eb d0                	jmp    8010343a <pipealloc+0x5a>
8010346a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103470:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103473:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010347a:	00 00 00 
  p->writeopen = 1;
8010347d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103484:	00 00 00 
  p->nwrite = 0;
80103487:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010348e:	00 00 00 
  p->nread = 0;
80103491:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103498:	00 00 00 
  initlock(&p->lock, "pipe");
8010349b:	68 68 77 10 80       	push   $0x80107768
801034a0:	50                   	push   %eax
801034a1:	e8 9a 10 00 00       	call   80104540 <initlock>
  (*f0)->type = FD_PIPE;
801034a6:	8b 03                	mov    (%ebx),%eax
  return 0;
801034a8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801034ab:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801034b1:	8b 03                	mov    (%ebx),%eax
801034b3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034b7:	8b 03                	mov    (%ebx),%eax
801034b9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034bd:	8b 03                	mov    (%ebx),%eax
801034bf:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034c2:	8b 06                	mov    (%esi),%eax
801034c4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034ca:	8b 06                	mov    (%esi),%eax
801034cc:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034d0:	8b 06                	mov    (%esi),%eax
801034d2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034d6:	8b 06                	mov    (%esi),%eax
801034d8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801034db:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034de:	31 c0                	xor    %eax,%eax
}
801034e0:	5b                   	pop    %ebx
801034e1:	5e                   	pop    %esi
801034e2:	5f                   	pop    %edi
801034e3:	5d                   	pop    %ebp
801034e4:	c3                   	ret    
801034e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801034f0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	56                   	push   %esi
801034f4:	53                   	push   %ebx
801034f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034fb:	83 ec 0c             	sub    $0xc,%esp
801034fe:	53                   	push   %ebx
801034ff:	e8 5c 10 00 00       	call   80104560 <acquire>
  if(writable){
80103504:	83 c4 10             	add    $0x10,%esp
80103507:	85 f6                	test   %esi,%esi
80103509:	74 45                	je     80103550 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010350b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103511:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103514:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010351b:	00 00 00 
    wakeup(&p->nread);
8010351e:	50                   	push   %eax
8010351f:	e8 bc 0b 00 00       	call   801040e0 <wakeup>
80103524:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103527:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010352d:	85 d2                	test   %edx,%edx
8010352f:	75 0a                	jne    8010353b <pipeclose+0x4b>
80103531:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103537:	85 c0                	test   %eax,%eax
80103539:	74 35                	je     80103570 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010353b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010353e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103541:	5b                   	pop    %ebx
80103542:	5e                   	pop    %esi
80103543:	5d                   	pop    %ebp
    release(&p->lock);
80103544:	e9 d7 11 00 00       	jmp    80104720 <release>
80103549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103550:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103556:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103559:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103560:	00 00 00 
    wakeup(&p->nwrite);
80103563:	50                   	push   %eax
80103564:	e8 77 0b 00 00       	call   801040e0 <wakeup>
80103569:	83 c4 10             	add    $0x10,%esp
8010356c:	eb b9                	jmp    80103527 <pipeclose+0x37>
8010356e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	53                   	push   %ebx
80103574:	e8 a7 11 00 00       	call   80104720 <release>
    kfree((char*)p);
80103579:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010357c:	83 c4 10             	add    $0x10,%esp
}
8010357f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103582:	5b                   	pop    %ebx
80103583:	5e                   	pop    %esi
80103584:	5d                   	pop    %ebp
    kfree((char*)p);
80103585:	e9 96 ed ff ff       	jmp    80102320 <kfree>
8010358a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103590 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103590:	55                   	push   %ebp
80103591:	89 e5                	mov    %esp,%ebp
80103593:	57                   	push   %edi
80103594:	56                   	push   %esi
80103595:	53                   	push   %ebx
80103596:	83 ec 28             	sub    $0x28,%esp
80103599:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010359c:	57                   	push   %edi
8010359d:	e8 be 0f 00 00       	call   80104560 <acquire>
  for(i = 0; i < n; i++){
801035a2:	8b 45 10             	mov    0x10(%ebp),%eax
801035a5:	83 c4 10             	add    $0x10,%esp
801035a8:	85 c0                	test   %eax,%eax
801035aa:	0f 8e c6 00 00 00    	jle    80103676 <pipewrite+0xe6>
801035b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801035b3:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
801035b9:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
801035bf:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
801035c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035c8:	03 45 10             	add    0x10(%ebp),%eax
801035cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035ce:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035d4:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801035da:	39 d1                	cmp    %edx,%ecx
801035dc:	0f 85 cf 00 00 00    	jne    801036b1 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
801035e2:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
801035e8:	85 d2                	test   %edx,%edx
801035ea:	0f 84 a8 00 00 00    	je     80103698 <pipewrite+0x108>
801035f0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801035f7:	8b 42 24             	mov    0x24(%edx),%eax
801035fa:	85 c0                	test   %eax,%eax
801035fc:	74 25                	je     80103623 <pipewrite+0x93>
801035fe:	e9 95 00 00 00       	jmp    80103698 <pipewrite+0x108>
80103603:	90                   	nop
80103604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103608:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
8010360e:	85 c0                	test   %eax,%eax
80103610:	0f 84 82 00 00 00    	je     80103698 <pipewrite+0x108>
80103616:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010361c:	8b 40 24             	mov    0x24(%eax),%eax
8010361f:	85 c0                	test   %eax,%eax
80103621:	75 75                	jne    80103698 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103623:	83 ec 0c             	sub    $0xc,%esp
80103626:	56                   	push   %esi
80103627:	e8 b4 0a 00 00       	call   801040e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010362c:	59                   	pop    %ecx
8010362d:	58                   	pop    %eax
8010362e:	57                   	push   %edi
8010362f:	53                   	push   %ebx
80103630:	e8 fb 08 00 00       	call   80103f30 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103635:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010363b:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103641:	83 c4 10             	add    $0x10,%esp
80103644:	05 00 02 00 00       	add    $0x200,%eax
80103649:	39 c2                	cmp    %eax,%edx
8010364b:	74 bb                	je     80103608 <pipewrite+0x78>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010364d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103650:	8d 4a 01             	lea    0x1(%edx),%ecx
80103653:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80103657:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010365d:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103663:	0f b6 00             	movzbl (%eax),%eax
80103666:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
8010366a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(i = 0; i < n; i++){
8010366d:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80103670:	0f 85 58 ff ff ff    	jne    801035ce <pipewrite+0x3e>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103676:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
8010367c:	83 ec 0c             	sub    $0xc,%esp
8010367f:	52                   	push   %edx
80103680:	e8 5b 0a 00 00       	call   801040e0 <wakeup>
  release(&p->lock);
80103685:	89 3c 24             	mov    %edi,(%esp)
80103688:	e8 93 10 00 00       	call   80104720 <release>
  return n;
8010368d:	83 c4 10             	add    $0x10,%esp
80103690:	8b 45 10             	mov    0x10(%ebp),%eax
80103693:	eb 14                	jmp    801036a9 <pipewrite+0x119>
80103695:	8d 76 00             	lea    0x0(%esi),%esi
        release(&p->lock);
80103698:	83 ec 0c             	sub    $0xc,%esp
8010369b:	57                   	push   %edi
8010369c:	e8 7f 10 00 00       	call   80104720 <release>
        return -1;
801036a1:	83 c4 10             	add    $0x10,%esp
801036a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801036a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ac:	5b                   	pop    %ebx
801036ad:	5e                   	pop    %esi
801036ae:	5f                   	pop    %edi
801036af:	5d                   	pop    %ebp
801036b0:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036b1:	89 ca                	mov    %ecx,%edx
801036b3:	eb 98                	jmp    8010364d <pipewrite+0xbd>
801036b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036c0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	57                   	push   %edi
801036c4:	56                   	push   %esi
801036c5:	53                   	push   %ebx
801036c6:	83 ec 18             	sub    $0x18,%esp
801036c9:	8b 75 08             	mov    0x8(%ebp),%esi
801036cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036cf:	56                   	push   %esi
801036d0:	e8 8b 0e 00 00       	call   80104560 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036d5:	83 c4 10             	add    $0x10,%esp
801036d8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036de:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036e4:	75 64                	jne    8010374a <piperead+0x8a>
801036e6:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
801036ec:	85 c0                	test   %eax,%eax
801036ee:	0f 84 bc 00 00 00    	je     801037b0 <piperead+0xf0>
    if(proc->killed){
801036f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801036fa:	8b 58 24             	mov    0x24(%eax),%ebx
801036fd:	85 db                	test   %ebx,%ebx
801036ff:	0f 85 b3 00 00 00    	jne    801037b8 <piperead+0xf8>
80103705:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010370b:	eb 22                	jmp    8010372f <piperead+0x6f>
8010370d:	8d 76 00             	lea    0x0(%esi),%esi
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103710:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103716:	85 d2                	test   %edx,%edx
80103718:	0f 84 92 00 00 00    	je     801037b0 <piperead+0xf0>
    if(proc->killed){
8010371e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103724:	8b 48 24             	mov    0x24(%eax),%ecx
80103727:	85 c9                	test   %ecx,%ecx
80103729:	0f 85 89 00 00 00    	jne    801037b8 <piperead+0xf8>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010372f:	83 ec 08             	sub    $0x8,%esp
80103732:	56                   	push   %esi
80103733:	53                   	push   %ebx
80103734:	e8 f7 07 00 00       	call   80103f30 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103739:	83 c4 10             	add    $0x10,%esp
8010373c:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103742:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103748:	74 c6                	je     80103710 <piperead+0x50>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010374a:	8b 45 10             	mov    0x10(%ebp),%eax
8010374d:	85 c0                	test   %eax,%eax
8010374f:	7e 5f                	jle    801037b0 <piperead+0xf0>
    if(p->nread == p->nwrite)
80103751:	31 db                	xor    %ebx,%ebx
80103753:	eb 11                	jmp    80103766 <piperead+0xa6>
80103755:	8d 76 00             	lea    0x0(%esi),%esi
80103758:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010375e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103764:	74 1f                	je     80103785 <piperead+0xc5>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103766:	8d 41 01             	lea    0x1(%ecx),%eax
80103769:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
8010376f:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103775:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
8010377a:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010377d:	83 c3 01             	add    $0x1,%ebx
80103780:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103783:	75 d3                	jne    80103758 <piperead+0x98>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103785:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
8010378b:	83 ec 0c             	sub    $0xc,%esp
8010378e:	50                   	push   %eax
8010378f:	e8 4c 09 00 00       	call   801040e0 <wakeup>
  release(&p->lock);
80103794:	89 34 24             	mov    %esi,(%esp)
80103797:	e8 84 0f 00 00       	call   80104720 <release>
  return i;
8010379c:	83 c4 10             	add    $0x10,%esp
}
8010379f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037a2:	89 d8                	mov    %ebx,%eax
801037a4:	5b                   	pop    %ebx
801037a5:	5e                   	pop    %esi
801037a6:	5f                   	pop    %edi
801037a7:	5d                   	pop    %ebp
801037a8:	c3                   	ret    
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
801037b0:	31 db                	xor    %ebx,%ebx
801037b2:	eb d1                	jmp    80103785 <piperead+0xc5>
801037b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
801037b8:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801037bb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801037c0:	56                   	push   %esi
801037c1:	e8 5a 0f 00 00       	call   80104720 <release>
      return -1;
801037c6:	83 c4 10             	add    $0x10,%esp
}
801037c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037cc:	89 d8                	mov    %ebx,%eax
801037ce:	5b                   	pop    %ebx
801037cf:	5e                   	pop    %esi
801037d0:	5f                   	pop    %edi
801037d1:	5d                   	pop    %ebp
801037d2:	c3                   	ret    
801037d3:	66 90                	xchg   %ax,%ax
801037d5:	66 90                	xchg   %ax,%ax
801037d7:	66 90                	xchg   %ax,%ax
801037d9:	66 90                	xchg   %ax,%ax
801037db:	66 90                	xchg   %ax,%ax
801037dd:	66 90                	xchg   %ax,%ax
801037df:	90                   	nop

801037e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037e4:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
{
801037e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037ec:	68 a0 2d 11 80       	push   $0x80112da0
801037f1:	e8 6a 0d 00 00       	call   80104560 <acquire>
801037f6:	83 c4 10             	add    $0x10,%esp
801037f9:	eb 17                	jmp    80103812 <allocproc+0x32>
801037fb:	90                   	nop
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103800:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103806:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
8010380c:	0f 83 96 00 00 00    	jae    801038a8 <allocproc+0xc8>
    if(p->state == UNUSED)
80103812:	8b 43 0c             	mov    0xc(%ebx),%eax
80103815:	85 c0                	test   %eax,%eax
80103817:	75 e7                	jne    80103800 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103819:	a1 08 a0 10 80       	mov    0x8010a008,%eax
  p->state = EMBRYO;
8010381e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103825:	8d 50 01             	lea    0x1(%eax),%edx
  p->ctime = ticks;
  if(p->pid >2){
    p->priority = 1;     //default Prioroty
80103828:	83 f8 03             	cmp    $0x3,%eax
  p->pid = nextpid++;
8010382b:	89 43 10             	mov    %eax,0x10(%ebx)
    p->priority = 1;     //default Prioroty
8010382e:	0f 9c c0             	setl   %al
  }
  else{
    p->priority=2;      // For init and "Sh"
  }

  release(&ptable.lock);
80103831:	83 ec 0c             	sub    $0xc,%esp
  p->pid = nextpid++;
80103834:	89 15 08 a0 10 80    	mov    %edx,0x8010a008
  p->ctime = ticks;
8010383a:	8b 15 20 57 11 80    	mov    0x80115720,%edx
    p->priority = 1;     //default Prioroty
80103840:	0f b6 c0             	movzbl %al,%eax
80103843:	83 c0 01             	add    $0x1,%eax
80103846:	89 43 7c             	mov    %eax,0x7c(%ebx)
  p->ctime = ticks;
80103849:	89 93 80 00 00 00    	mov    %edx,0x80(%ebx)
  release(&ptable.lock);
8010384f:	68 a0 2d 11 80       	push   $0x80112da0
80103854:	e8 c7 0e 00 00       	call   80104720 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103859:	e8 72 ec ff ff       	call   801024d0 <kalloc>
8010385e:	83 c4 10             	add    $0x10,%esp
80103861:	85 c0                	test   %eax,%eax
80103863:	89 43 08             	mov    %eax,0x8(%ebx)
80103866:	74 59                	je     801038c1 <allocproc+0xe1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103868:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010386e:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103871:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103876:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103879:	c7 40 14 1e 5a 10 80 	movl   $0x80105a1e,0x14(%eax)
  p->context = (struct context*)sp;
80103880:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103883:	6a 14                	push   $0x14
80103885:	6a 00                	push   $0x0
80103887:	50                   	push   %eax
80103888:	e8 e3 0e 00 00       	call   80104770 <memset>
  p->context->eip = (uint)forkret;
8010388d:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103890:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103893:	c7 40 10 d0 38 10 80 	movl   $0x801038d0,0x10(%eax)
}
8010389a:	89 d8                	mov    %ebx,%eax
8010389c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010389f:	c9                   	leave  
801038a0:	c3                   	ret    
801038a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801038a8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801038ab:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801038ad:	68 a0 2d 11 80       	push   $0x80112da0
801038b2:	e8 69 0e 00 00       	call   80104720 <release>
}
801038b7:	89 d8                	mov    %ebx,%eax
  return 0;
801038b9:	83 c4 10             	add    $0x10,%esp
}
801038bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038bf:	c9                   	leave  
801038c0:	c3                   	ret    
    p->state = UNUSED;
801038c1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801038c8:	31 db                	xor    %ebx,%ebx
801038ca:	eb ce                	jmp    8010389a <allocproc+0xba>
801038cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038d0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038d6:	68 a0 2d 11 80       	push   $0x80112da0
801038db:	e8 40 0e 00 00       	call   80104720 <release>

  if (first) {
801038e0:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801038e5:	83 c4 10             	add    $0x10,%esp
801038e8:	85 c0                	test   %eax,%eax
801038ea:	75 04                	jne    801038f0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038ec:	c9                   	leave  
801038ed:	c3                   	ret    
801038ee:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801038f0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801038f3:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
801038fa:	00 00 00 
    iinit(ROOTDEV);
801038fd:	6a 01                	push   $0x1
801038ff:	e8 7c db ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
80103904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010390b:	e8 90 f2 ff ff       	call   80102ba0 <initlog>
80103910:	83 c4 10             	add    $0x10,%esp
}
80103913:	c9                   	leave  
80103914:	c3                   	ret    
80103915:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103920 <pinit>:
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103926:	68 6d 77 10 80       	push   $0x8010776d
8010392b:	68 a0 2d 11 80       	push   $0x80112da0
80103930:	e8 0b 0c 00 00       	call   80104540 <initlock>
}
80103935:	83 c4 10             	add    $0x10,%esp
80103938:	c9                   	leave  
80103939:	c3                   	ret    
8010393a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103940 <userinit>:
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	53                   	push   %ebx
80103944:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103947:	e8 94 fe ff ff       	call   801037e0 <allocproc>
8010394c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010394e:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
80103953:	e8 58 32 00 00       	call   80106bb0 <setupkvm>
80103958:	85 c0                	test   %eax,%eax
8010395a:	89 43 04             	mov    %eax,0x4(%ebx)
8010395d:	0f 84 bd 00 00 00    	je     80103a20 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103963:	83 ec 04             	sub    $0x4,%esp
80103966:	68 2c 00 00 00       	push   $0x2c
8010396b:	68 60 a4 10 80       	push   $0x8010a460
80103970:	50                   	push   %eax
80103971:	e8 8a 33 00 00       	call   80106d00 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103976:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103979:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010397f:	6a 4c                	push   $0x4c
80103981:	6a 00                	push   $0x0
80103983:	ff 73 18             	pushl  0x18(%ebx)
80103986:	e8 e5 0d 00 00       	call   80104770 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010398b:	8b 43 18             	mov    0x18(%ebx),%eax
8010398e:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103993:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103998:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010399b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010399f:	8b 43 18             	mov    0x18(%ebx),%eax
801039a2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039a6:	8b 43 18             	mov    0x18(%ebx),%eax
801039a9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039ad:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039b1:	8b 43 18             	mov    0x18(%ebx),%eax
801039b4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039b8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039bc:	8b 43 18             	mov    0x18(%ebx),%eax
801039bf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039c6:	8b 43 18             	mov    0x18(%ebx),%eax
801039c9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801039d0:	8b 43 18             	mov    0x18(%ebx),%eax
801039d3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039da:	8d 43 6c             	lea    0x6c(%ebx),%eax
801039dd:	6a 10                	push   $0x10
801039df:	68 8d 77 10 80       	push   $0x8010778d
801039e4:	50                   	push   %eax
801039e5:	e8 86 0f 00 00       	call   80104970 <safestrcpy>
  p->cwd = namei("/");
801039ea:	c7 04 24 96 77 10 80 	movl   $0x80107796,(%esp)
801039f1:	e8 ca e4 ff ff       	call   80101ec0 <namei>
801039f6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801039f9:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a00:	e8 5b 0b 00 00       	call   80104560 <acquire>
  p->state = RUNNABLE;
80103a05:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a0c:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a13:	e8 08 0d 00 00       	call   80104720 <release>
}
80103a18:	83 c4 10             	add    $0x10,%esp
80103a1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a1e:	c9                   	leave  
80103a1f:	c3                   	ret    
    panic("userinit: out of memory?");
80103a20:	83 ec 0c             	sub    $0xc,%esp
80103a23:	68 74 77 10 80       	push   $0x80107774
80103a28:	e8 63 c9 ff ff       	call   80100390 <panic>
80103a2d:	8d 76 00             	lea    0x0(%esi),%esi

80103a30 <growproc>:
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	83 ec 08             	sub    $0x8,%esp
  sz = proc->sz;
80103a36:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103a3d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  sz = proc->sz;
80103a40:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103a42:	83 f9 00             	cmp    $0x0,%ecx
80103a45:	7f 21                	jg     80103a68 <growproc+0x38>
  } else if(n < 0){
80103a47:	75 47                	jne    80103a90 <growproc+0x60>
  proc->sz = sz;
80103a49:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103a4b:	83 ec 0c             	sub    $0xc,%esp
80103a4e:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103a55:	e8 06 32 00 00       	call   80106c60 <switchuvm>
  return 0;
80103a5a:	83 c4 10             	add    $0x10,%esp
80103a5d:	31 c0                	xor    %eax,%eax
}
80103a5f:	c9                   	leave  
80103a60:	c3                   	ret    
80103a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103a68:	83 ec 04             	sub    $0x4,%esp
80103a6b:	01 c1                	add    %eax,%ecx
80103a6d:	51                   	push   %ecx
80103a6e:	50                   	push   %eax
80103a6f:	ff 72 04             	pushl  0x4(%edx)
80103a72:	e8 c9 33 00 00       	call   80106e40 <allocuvm>
80103a77:	83 c4 10             	add    $0x10,%esp
80103a7a:	85 c0                	test   %eax,%eax
80103a7c:	74 28                	je     80103aa6 <growproc+0x76>
80103a7e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a85:	eb c2                	jmp    80103a49 <growproc+0x19>
80103a87:	89 f6                	mov    %esi,%esi
80103a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103a90:	83 ec 04             	sub    $0x4,%esp
80103a93:	01 c1                	add    %eax,%ecx
80103a95:	51                   	push   %ecx
80103a96:	50                   	push   %eax
80103a97:	ff 72 04             	pushl  0x4(%edx)
80103a9a:	e8 d1 34 00 00       	call   80106f70 <deallocuvm>
80103a9f:	83 c4 10             	add    $0x10,%esp
80103aa2:	85 c0                	test   %eax,%eax
80103aa4:	75 d8                	jne    80103a7e <growproc+0x4e>
      return -1;
80103aa6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103aab:	c9                   	leave  
80103aac:	c3                   	ret    
80103aad:	8d 76 00             	lea    0x0(%esi),%esi

80103ab0 <fork>:
{
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	57                   	push   %edi
80103ab4:	56                   	push   %esi
80103ab5:	53                   	push   %ebx
80103ab6:	83 ec 0c             	sub    $0xc,%esp
  if((np = allocproc()) == 0){
80103ab9:	e8 22 fd ff ff       	call   801037e0 <allocproc>
80103abe:	85 c0                	test   %eax,%eax
80103ac0:	0f 84 d6 00 00 00    	je     80103b9c <fork+0xec>
80103ac6:	89 c3                	mov    %eax,%ebx
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103ac8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ace:	83 ec 08             	sub    $0x8,%esp
80103ad1:	ff 30                	pushl  (%eax)
80103ad3:	ff 70 04             	pushl  0x4(%eax)
80103ad6:	e8 75 35 00 00       	call   80107050 <copyuvm>
80103adb:	83 c4 10             	add    $0x10,%esp
80103ade:	85 c0                	test   %eax,%eax
80103ae0:	89 43 04             	mov    %eax,0x4(%ebx)
80103ae3:	0f 84 ba 00 00 00    	je     80103ba3 <fork+0xf3>
  np->sz = proc->sz;
80103ae9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *np->tf = *proc->tf;
80103aef:	8b 7b 18             	mov    0x18(%ebx),%edi
80103af2:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = proc->sz;
80103af7:	8b 00                	mov    (%eax),%eax
80103af9:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103afb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103b01:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103b04:	8b 70 18             	mov    0x18(%eax),%esi
80103b07:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b09:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b0b:	8b 43 18             	mov    0x18(%ebx),%eax
80103b0e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103b15:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[i])
80103b20:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103b24:	85 c0                	test   %eax,%eax
80103b26:	74 17                	je     80103b3f <fork+0x8f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103b28:	83 ec 0c             	sub    $0xc,%esp
80103b2b:	50                   	push   %eax
80103b2c:	e8 af d2 ff ff       	call   80100de0 <filedup>
80103b31:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103b35:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103b3c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
80103b3f:	83 c6 01             	add    $0x1,%esi
80103b42:	83 fe 10             	cmp    $0x10,%esi
80103b45:	75 d9                	jne    80103b20 <fork+0x70>
  np->cwd = idup(proc->cwd);
80103b47:	83 ec 0c             	sub    $0xc,%esp
80103b4a:	ff 72 68             	pushl  0x68(%edx)
80103b4d:	e8 fe da ff ff       	call   80101650 <idup>
80103b52:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103b55:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103b5b:	83 c4 0c             	add    $0xc,%esp
80103b5e:	6a 10                	push   $0x10
80103b60:	83 c0 6c             	add    $0x6c,%eax
80103b63:	50                   	push   %eax
80103b64:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b67:	50                   	push   %eax
80103b68:	e8 03 0e 00 00       	call   80104970 <safestrcpy>
  pid = np->pid;
80103b6d:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103b70:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b77:	e8 e4 09 00 00       	call   80104560 <acquire>
  np->state = RUNNABLE;
80103b7c:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103b83:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b8a:	e8 91 0b 00 00       	call   80104720 <release>
  return pid;
80103b8f:	83 c4 10             	add    $0x10,%esp
}
80103b92:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b95:	89 f0                	mov    %esi,%eax
80103b97:	5b                   	pop    %ebx
80103b98:	5e                   	pop    %esi
80103b99:	5f                   	pop    %edi
80103b9a:	5d                   	pop    %ebp
80103b9b:	c3                   	ret    
    return -1;
80103b9c:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103ba1:	eb ef                	jmp    80103b92 <fork+0xe2>
    kfree(np->kstack);
80103ba3:	83 ec 0c             	sub    $0xc,%esp
80103ba6:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80103ba9:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103bae:	e8 6d e7 ff ff       	call   80102320 <kfree>
    np->kstack = 0;
80103bb3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103bba:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103bc1:	83 c4 10             	add    $0x10,%esp
80103bc4:	eb cc                	jmp    80103b92 <fork+0xe2>
80103bc6:	8d 76 00             	lea    0x0(%esi),%esi
80103bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bd0 <scheduler>:
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	53                   	push   %ebx
80103bd4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("sti");
80103bd7:	fb                   	sti    
      acquire(&ptable.lock);
80103bd8:	83 ec 0c             	sub    $0xc,%esp
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bdb:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
      acquire(&ptable.lock);
80103be0:	68 a0 2d 11 80       	push   $0x80112da0
80103be5:	e8 76 09 00 00       	call   80104560 <acquire>
80103bea:	83 c4 10             	add    $0x10,%esp
80103bed:	eb 13                	jmp    80103c02 <scheduler+0x32>
80103bef:	90                   	nop
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bf0:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103bf6:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103bfc:	0f 83 bc 00 00 00    	jae    80103cbe <scheduler+0xee>
          if(p->state != RUNNABLE)
80103c02:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c06:	75 e8                	jne    80103bf0 <scheduler+0x20>
80103c08:	8b 4b 7c             	mov    0x7c(%ebx),%ecx
          for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c0b:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103c10:	eb 14                	jmp    80103c26 <scheduler+0x56>
80103c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if(p->priority == highP->priority){
80103c18:	74 1b                	je     80103c35 <scheduler+0x65>
          for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c1a:	05 84 00 00 00       	add    $0x84,%eax
80103c1f:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103c24:	73 3a                	jae    80103c60 <scheduler+0x90>
            if(p->state != RUNNABLE)
80103c26:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103c2a:	75 ee                	jne    80103c1a <scheduler+0x4a>
            if (p->priority >highP->priority )   // larger value, larger priority 
80103c2c:	8b 50 7c             	mov    0x7c(%eax),%edx
80103c2f:	39 ca                	cmp    %ecx,%edx
80103c31:	7e e5                	jle    80103c18 <scheduler+0x48>
80103c33:	89 c3                	mov    %eax,%ebx
               if(p->ctime < highP->ctime)
80103c35:	8b 8b 80 00 00 00    	mov    0x80(%ebx),%ecx
80103c3b:	39 88 80 00 00 00    	cmp    %ecx,0x80(%eax)
80103c41:	0f 82 91 00 00 00    	jb     80103cd8 <scheduler+0x108>
          for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c47:	05 84 00 00 00       	add    $0x84,%eax
80103c4c:	8b 4b 7c             	mov    0x7c(%ebx),%ecx
80103c4f:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103c54:	72 d0                	jb     80103c26 <scheduler+0x56>
80103c56:	8d 76 00             	lea    0x0(%esi),%esi
80103c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(p->priority ==1 || p->priority==2){
80103c60:	83 e9 01             	sub    $0x1,%ecx
              proc = p;
80103c63:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
            if(p->priority ==1 || p->priority==2){
80103c6a:	83 f9 01             	cmp    $0x1,%ecx
80103c6d:	76 72                	jbe    80103ce1 <scheduler+0x111>
              switchuvm(p);
80103c6f:	83 ec 0c             	sub    $0xc,%esp
80103c72:	53                   	push   %ebx
80103c73:	e8 e8 2f 00 00       	call   80106c60 <switchuvm>
              p->state = RUNNING;
80103c78:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c7f:	81 c3 84 00 00 00    	add    $0x84,%ebx
              swtch(&cpu->scheduler, proc->context);
80103c85:	58                   	pop    %eax
80103c86:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c8c:	5a                   	pop    %edx
80103c8d:	ff 70 1c             	pushl  0x1c(%eax)
80103c90:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103c96:	83 c0 04             	add    $0x4,%eax
80103c99:	50                   	push   %eax
80103c9a:	e8 2c 0d 00 00       	call   801049cb <swtch>
              switchkvm();
80103c9f:	e8 9c 2f 00 00       	call   80106c40 <switchkvm>
80103ca4:	83 c4 10             	add    $0x10,%esp
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ca7:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
          proc = 0;
80103cad:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103cb4:	00 00 00 00 
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cb8:	0f 82 44 ff ff ff    	jb     80103c02 <scheduler+0x32>
        release(&ptable.lock);
80103cbe:	83 ec 0c             	sub    $0xc,%esp
80103cc1:	68 a0 2d 11 80       	push   $0x80112da0
80103cc6:	e8 55 0a 00 00       	call   80104720 <release>
      sti();
80103ccb:	83 c4 10             	add    $0x10,%esp
80103cce:	e9 04 ff ff ff       	jmp    80103bd7 <scheduler+0x7>
80103cd3:	90                   	nop
80103cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if (p->priority >highP->priority )   // larger value, larger priority 
80103cd8:	89 d1                	mov    %edx,%ecx
80103cda:	89 c3                	mov    %eax,%ebx
80103cdc:	e9 39 ff ff ff       	jmp    80103c1a <scheduler+0x4a>
              switchuvm(p);
80103ce1:	83 ec 0c             	sub    $0xc,%esp
80103ce4:	53                   	push   %ebx
80103ce5:	e8 76 2f 00 00       	call   80106c60 <switchuvm>
              p->ctime = ticks;
80103cea:	a1 20 57 11 80       	mov    0x80115720,%eax
80103cef:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
80103cf5:	eb 81                	jmp    80103c78 <scheduler+0xa8>
80103cf7:	89 f6                	mov    %esi,%esi
80103cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d00 <sched>:
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	53                   	push   %ebx
80103d04:	83 ec 10             	sub    $0x10,%esp
  if(!holding(&ptable.lock))
80103d07:	68 a0 2d 11 80       	push   $0x80112da0
80103d0c:	e8 5f 09 00 00       	call   80104670 <holding>
80103d11:	83 c4 10             	add    $0x10,%esp
80103d14:	85 c0                	test   %eax,%eax
80103d16:	74 4c                	je     80103d64 <sched+0x64>
  if(cpu->ncli != 1)
80103d18:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103d1f:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103d26:	75 63                	jne    80103d8b <sched+0x8b>
  if(proc->state == RUNNING)
80103d28:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d2e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103d32:	74 4a                	je     80103d7e <sched+0x7e>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d34:	9c                   	pushf  
80103d35:	59                   	pop    %ecx
  if(readeflags()&FL_IF)
80103d36:	80 e5 02             	and    $0x2,%ch
80103d39:	75 36                	jne    80103d71 <sched+0x71>
  swtch(&proc->context, cpu->scheduler);
80103d3b:	83 ec 08             	sub    $0x8,%esp
80103d3e:	83 c0 1c             	add    $0x1c,%eax
  intena = cpu->intena;
80103d41:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103d47:	ff 72 04             	pushl  0x4(%edx)
80103d4a:	50                   	push   %eax
80103d4b:	e8 7b 0c 00 00       	call   801049cb <swtch>
  cpu->intena = intena;
80103d50:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103d56:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80103d59:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103d5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d62:	c9                   	leave  
80103d63:	c3                   	ret    
    panic("sched ptable.lock");
80103d64:	83 ec 0c             	sub    $0xc,%esp
80103d67:	68 98 77 10 80       	push   $0x80107798
80103d6c:	e8 1f c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103d71:	83 ec 0c             	sub    $0xc,%esp
80103d74:	68 c4 77 10 80       	push   $0x801077c4
80103d79:	e8 12 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103d7e:	83 ec 0c             	sub    $0xc,%esp
80103d81:	68 b6 77 10 80       	push   $0x801077b6
80103d86:	e8 05 c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103d8b:	83 ec 0c             	sub    $0xc,%esp
80103d8e:	68 aa 77 10 80       	push   $0x801077aa
80103d93:	e8 f8 c5 ff ff       	call   80100390 <panic>
80103d98:	90                   	nop
80103d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103da0 <exit>:
{
80103da0:	55                   	push   %ebp
  if(proc == initproc)
80103da1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103da8:	89 e5                	mov    %esp,%ebp
80103daa:	56                   	push   %esi
80103dab:	53                   	push   %ebx
80103dac:	31 db                	xor    %ebx,%ebx
  if(proc == initproc)
80103dae:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
80103db4:	0f 84 27 01 00 00    	je     80103ee1 <exit+0x141>
80103dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[fd]){
80103dc0:	8d 73 08             	lea    0x8(%ebx),%esi
80103dc3:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103dc7:	85 c0                	test   %eax,%eax
80103dc9:	74 1b                	je     80103de6 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103dcb:	83 ec 0c             	sub    $0xc,%esp
80103dce:	50                   	push   %eax
80103dcf:	e8 5c d0 ff ff       	call   80100e30 <fileclose>
      proc->ofile[fd] = 0;
80103dd4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103ddb:	83 c4 10             	add    $0x10,%esp
80103dde:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103de5:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103de6:	83 c3 01             	add    $0x1,%ebx
80103de9:	83 fb 10             	cmp    $0x10,%ebx
80103dec:	75 d2                	jne    80103dc0 <exit+0x20>
  begin_op();
80103dee:	e8 4d ee ff ff       	call   80102c40 <begin_op>
  iput(proc->cwd);
80103df3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103df9:	83 ec 0c             	sub    $0xc,%esp
80103dfc:	ff 70 68             	pushl  0x68(%eax)
80103dff:	e8 ac d9 ff ff       	call   801017b0 <iput>
  end_op();
80103e04:	e8 a7 ee ff ff       	call   80102cb0 <end_op>
  proc->cwd = 0;
80103e09:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e0f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
  acquire(&ptable.lock);
80103e16:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e1d:	e8 3e 07 00 00       	call   80104560 <acquire>
  wakeup1(proc->parent);
80103e22:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80103e29:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e2c:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  wakeup1(proc->parent);
80103e31:	8b 53 14             	mov    0x14(%ebx),%edx
80103e34:	eb 16                	jmp    80103e4c <exit+0xac>
80103e36:	8d 76 00             	lea    0x0(%esi),%esi
80103e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e40:	05 84 00 00 00       	add    $0x84,%eax
80103e45:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103e4a:	73 1e                	jae    80103e6a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
80103e4c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e50:	75 ee                	jne    80103e40 <exit+0xa0>
80103e52:	3b 50 20             	cmp    0x20(%eax),%edx
80103e55:	75 e9                	jne    80103e40 <exit+0xa0>
      p->state = RUNNABLE;
80103e57:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e5e:	05 84 00 00 00       	add    $0x84,%eax
80103e63:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103e68:	72 e2                	jb     80103e4c <exit+0xac>
      p->parent = initproc;
80103e6a:	8b 0d bc a5 10 80    	mov    0x8010a5bc,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e70:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103e75:	eb 17                	jmp    80103e8e <exit+0xee>
80103e77:	89 f6                	mov    %esi,%esi
80103e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103e80:	81 c2 84 00 00 00    	add    $0x84,%edx
80103e86:	81 fa d4 4e 11 80    	cmp    $0x80114ed4,%edx
80103e8c:	73 3a                	jae    80103ec8 <exit+0x128>
    if(p->parent == proc){
80103e8e:	3b 5a 14             	cmp    0x14(%edx),%ebx
80103e91:	75 ed                	jne    80103e80 <exit+0xe0>
      if(p->state == ZOMBIE)
80103e93:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e97:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e9a:	75 e4                	jne    80103e80 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e9c:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103ea1:	eb 11                	jmp    80103eb4 <exit+0x114>
80103ea3:	90                   	nop
80103ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ea8:	05 84 00 00 00       	add    $0x84,%eax
80103ead:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103eb2:	73 cc                	jae    80103e80 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80103eb4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103eb8:	75 ee                	jne    80103ea8 <exit+0x108>
80103eba:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ebd:	75 e9                	jne    80103ea8 <exit+0x108>
      p->state = RUNNABLE;
80103ebf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103ec6:	eb e0                	jmp    80103ea8 <exit+0x108>
  proc->state = ZOMBIE;
80103ec8:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103ecf:	e8 2c fe ff ff       	call   80103d00 <sched>
  panic("zombie exit");
80103ed4:	83 ec 0c             	sub    $0xc,%esp
80103ed7:	68 e5 77 10 80       	push   $0x801077e5
80103edc:	e8 af c4 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103ee1:	83 ec 0c             	sub    $0xc,%esp
80103ee4:	68 d8 77 10 80       	push   $0x801077d8
80103ee9:	e8 a2 c4 ff ff       	call   80100390 <panic>
80103eee:	66 90                	xchg   %ax,%ax

80103ef0 <yield>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ef6:	68 a0 2d 11 80       	push   $0x80112da0
80103efb:	e8 60 06 00 00       	call   80104560 <acquire>
  proc->state = RUNNABLE;
80103f00:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f06:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103f0d:	e8 ee fd ff ff       	call   80103d00 <sched>
  release(&ptable.lock);
80103f12:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103f19:	e8 02 08 00 00       	call   80104720 <release>
}
80103f1e:	83 c4 10             	add    $0x10,%esp
80103f21:	c9                   	leave  
80103f22:	c3                   	ret    
80103f23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f30 <sleep>:
  if(proc == 0)
80103f30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80103f36:	55                   	push   %ebp
80103f37:	89 e5                	mov    %esp,%ebp
80103f39:	56                   	push   %esi
80103f3a:	53                   	push   %ebx
  if(proc == 0)
80103f3b:	85 c0                	test   %eax,%eax
{
80103f3d:	8b 75 08             	mov    0x8(%ebp),%esi
80103f40:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103f43:	0f 84 97 00 00 00    	je     80103fe0 <sleep+0xb0>
  if(lk == 0)
80103f49:	85 db                	test   %ebx,%ebx
80103f4b:	0f 84 82 00 00 00    	je     80103fd3 <sleep+0xa3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f51:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103f57:	74 57                	je     80103fb0 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f59:	83 ec 0c             	sub    $0xc,%esp
80103f5c:	68 a0 2d 11 80       	push   $0x80112da0
80103f61:	e8 fa 05 00 00       	call   80104560 <acquire>
    release(lk);
80103f66:	89 1c 24             	mov    %ebx,(%esp)
80103f69:	e8 b2 07 00 00       	call   80104720 <release>
  proc->chan = chan;
80103f6e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f74:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103f77:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103f7e:	e8 7d fd ff ff       	call   80103d00 <sched>
  proc->chan = 0;
80103f83:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f89:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
    release(&ptable.lock);
80103f90:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103f97:	e8 84 07 00 00       	call   80104720 <release>
    acquire(lk);
80103f9c:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103f9f:	83 c4 10             	add    $0x10,%esp
}
80103fa2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fa5:	5b                   	pop    %ebx
80103fa6:	5e                   	pop    %esi
80103fa7:	5d                   	pop    %ebp
    acquire(lk);
80103fa8:	e9 b3 05 00 00       	jmp    80104560 <acquire>
80103fad:	8d 76 00             	lea    0x0(%esi),%esi
  proc->chan = chan;
80103fb0:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103fb3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103fba:	e8 41 fd ff ff       	call   80103d00 <sched>
  proc->chan = 0;
80103fbf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103fc5:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
80103fcc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fcf:	5b                   	pop    %ebx
80103fd0:	5e                   	pop    %esi
80103fd1:	5d                   	pop    %ebp
80103fd2:	c3                   	ret    
    panic("sleep without lk");
80103fd3:	83 ec 0c             	sub    $0xc,%esp
80103fd6:	68 f7 77 10 80       	push   $0x801077f7
80103fdb:	e8 b0 c3 ff ff       	call   80100390 <panic>
    panic("sleep");
80103fe0:	83 ec 0c             	sub    $0xc,%esp
80103fe3:	68 f1 77 10 80       	push   $0x801077f1
80103fe8:	e8 a3 c3 ff ff       	call   80100390 <panic>
80103fed:	8d 76 00             	lea    0x0(%esi),%esi

80103ff0 <wait>:
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	56                   	push   %esi
80103ff4:	53                   	push   %ebx
  acquire(&ptable.lock);
80103ff5:	83 ec 0c             	sub    $0xc,%esp
80103ff8:	68 a0 2d 11 80       	push   $0x80112da0
80103ffd:	e8 5e 05 00 00       	call   80104560 <acquire>
80104002:	83 c4 10             	add    $0x10,%esp
      if(p->parent != proc)
80104005:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    havekids = 0;
8010400b:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010400d:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80104012:	eb 12                	jmp    80104026 <wait+0x36>
80104014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104018:	81 c3 84 00 00 00    	add    $0x84,%ebx
8010401e:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80104024:	73 1e                	jae    80104044 <wait+0x54>
      if(p->parent != proc)
80104026:	39 43 14             	cmp    %eax,0x14(%ebx)
80104029:	75 ed                	jne    80104018 <wait+0x28>
      if(p->state == ZOMBIE){
8010402b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010402f:	74 37                	je     80104068 <wait+0x78>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104031:	81 c3 84 00 00 00    	add    $0x84,%ebx
      havekids = 1;
80104037:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010403c:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80104042:	72 e2                	jb     80104026 <wait+0x36>
    if(!havekids || proc->killed){
80104044:	85 d2                	test   %edx,%edx
80104046:	74 7d                	je     801040c5 <wait+0xd5>
80104048:	8b 50 24             	mov    0x24(%eax),%edx
8010404b:	85 d2                	test   %edx,%edx
8010404d:	75 76                	jne    801040c5 <wait+0xd5>
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
8010404f:	83 ec 08             	sub    $0x8,%esp
80104052:	68 a0 2d 11 80       	push   $0x80112da0
80104057:	50                   	push   %eax
80104058:	e8 d3 fe ff ff       	call   80103f30 <sleep>
    havekids = 0;
8010405d:	83 c4 10             	add    $0x10,%esp
80104060:	eb a3                	jmp    80104005 <wait+0x15>
80104062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104068:	83 ec 0c             	sub    $0xc,%esp
8010406b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010406e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104071:	e8 aa e2 ff ff       	call   80102320 <kfree>
        freevm(p->pgdir);
80104076:	59                   	pop    %ecx
80104077:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010407a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104081:	e8 1a 2f 00 00       	call   80106fa0 <freevm>
        release(&ptable.lock);
80104086:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
        p->pid = 0;
8010408d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104094:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010409b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010409f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801040a6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->priority = 2;
801040ad:	c7 43 7c 02 00 00 00 	movl   $0x2,0x7c(%ebx)
        release(&ptable.lock);
801040b4:	e8 67 06 00 00       	call   80104720 <release>
        return pid;
801040b9:	83 c4 10             	add    $0x10,%esp
}
801040bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040bf:	89 f0                	mov    %esi,%eax
801040c1:	5b                   	pop    %ebx
801040c2:	5e                   	pop    %esi
801040c3:	5d                   	pop    %ebp
801040c4:	c3                   	ret    
      release(&ptable.lock);
801040c5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801040c8:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801040cd:	68 a0 2d 11 80       	push   $0x80112da0
801040d2:	e8 49 06 00 00       	call   80104720 <release>
      return -1;
801040d7:	83 c4 10             	add    $0x10,%esp
801040da:	eb e0                	jmp    801040bc <wait+0xcc>
801040dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801040e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	53                   	push   %ebx
801040e4:	83 ec 10             	sub    $0x10,%esp
801040e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ea:	68 a0 2d 11 80       	push   $0x80112da0
801040ef:	e8 6c 04 00 00       	call   80104560 <acquire>
801040f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040f7:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
801040fc:	eb 0e                	jmp    8010410c <wakeup+0x2c>
801040fe:	66 90                	xchg   %ax,%ax
80104100:	05 84 00 00 00       	add    $0x84,%eax
80104105:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
8010410a:	73 1e                	jae    8010412a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010410c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104110:	75 ee                	jne    80104100 <wakeup+0x20>
80104112:	3b 58 20             	cmp    0x20(%eax),%ebx
80104115:	75 e9                	jne    80104100 <wakeup+0x20>
      p->state = RUNNABLE;
80104117:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010411e:	05 84 00 00 00       	add    $0x84,%eax
80104123:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80104128:	72 e2                	jb     8010410c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010412a:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
80104131:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104134:	c9                   	leave  
  release(&ptable.lock);
80104135:	e9 e6 05 00 00       	jmp    80104720 <release>
8010413a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104140 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	53                   	push   %ebx
80104144:	83 ec 10             	sub    $0x10,%esp
80104147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010414a:	68 a0 2d 11 80       	push   $0x80112da0
8010414f:	e8 0c 04 00 00       	call   80104560 <acquire>
80104154:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104157:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010415c:	eb 0e                	jmp    8010416c <kill+0x2c>
8010415e:	66 90                	xchg   %ax,%ax
80104160:	05 84 00 00 00       	add    $0x84,%eax
80104165:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
8010416a:	73 34                	jae    801041a0 <kill+0x60>
    if(p->pid == pid){
8010416c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010416f:	75 ef                	jne    80104160 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104171:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104175:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010417c:	75 07                	jne    80104185 <kill+0x45>
        p->state = RUNNABLE;
8010417e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104185:	83 ec 0c             	sub    $0xc,%esp
80104188:	68 a0 2d 11 80       	push   $0x80112da0
8010418d:	e8 8e 05 00 00       	call   80104720 <release>
      return 0;
80104192:	83 c4 10             	add    $0x10,%esp
80104195:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104197:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010419a:	c9                   	leave  
8010419b:	c3                   	ret    
8010419c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801041a0:	83 ec 0c             	sub    $0xc,%esp
801041a3:	68 a0 2d 11 80       	push   $0x80112da0
801041a8:	e8 73 05 00 00       	call   80104720 <release>
  return -1;
801041ad:	83 c4 10             	add    $0x10,%esp
801041b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041b8:	c9                   	leave  
801041b9:	c3                   	ret    
801041ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041c0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	57                   	push   %edi
801041c4:	56                   	push   %esi
801041c5:	53                   	push   %ebx
801041c6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041c9:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
{
801041ce:	83 ec 3c             	sub    $0x3c,%esp
801041d1:	eb 27                	jmp    801041fa <procdump+0x3a>
801041d3:	90                   	nop
801041d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041d8:	83 ec 0c             	sub    $0xc,%esp
801041db:	68 46 77 10 80       	push   $0x80107746
801041e0:	e8 7b c4 ff ff       	call   80100660 <cprintf>
801041e5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e8:	81 c3 84 00 00 00    	add    $0x84,%ebx
801041ee:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
801041f4:	0f 83 86 00 00 00    	jae    80104280 <procdump+0xc0>
    if(p->state == UNUSED)
801041fa:	8b 43 0c             	mov    0xc(%ebx),%eax
801041fd:	85 c0                	test   %eax,%eax
801041ff:	74 e7                	je     801041e8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104201:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104204:	ba 08 78 10 80       	mov    $0x80107808,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104209:	77 11                	ja     8010421c <procdump+0x5c>
8010420b:	8b 14 85 b4 78 10 80 	mov    -0x7fef874c(,%eax,4),%edx
      state = "???";
80104212:	b8 08 78 10 80       	mov    $0x80107808,%eax
80104217:	85 d2                	test   %edx,%edx
80104219:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010421c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010421f:	50                   	push   %eax
80104220:	52                   	push   %edx
80104221:	ff 73 10             	pushl  0x10(%ebx)
80104224:	68 0c 78 10 80       	push   $0x8010780c
80104229:	e8 32 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010422e:	83 c4 10             	add    $0x10,%esp
80104231:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104235:	75 a1                	jne    801041d8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104237:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010423a:	83 ec 08             	sub    $0x8,%esp
8010423d:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104240:	50                   	push   %eax
80104241:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104244:	8b 40 0c             	mov    0xc(%eax),%eax
80104247:	83 c0 08             	add    $0x8,%eax
8010424a:	50                   	push   %eax
8010424b:	e8 d0 03 00 00       	call   80104620 <getcallerpcs>
80104250:	83 c4 10             	add    $0x10,%esp
80104253:	90                   	nop
80104254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104258:	8b 17                	mov    (%edi),%edx
8010425a:	85 d2                	test   %edx,%edx
8010425c:	0f 84 76 ff ff ff    	je     801041d8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104262:	83 ec 08             	sub    $0x8,%esp
80104265:	83 c7 04             	add    $0x4,%edi
80104268:	52                   	push   %edx
80104269:	68 69 72 10 80       	push   $0x80107269
8010426e:	e8 ed c3 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104273:	83 c4 10             	add    $0x10,%esp
80104276:	39 fe                	cmp    %edi,%esi
80104278:	75 de                	jne    80104258 <procdump+0x98>
8010427a:	e9 59 ff ff ff       	jmp    801041d8 <procdump+0x18>
8010427f:	90                   	nop
  }
}
80104280:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104283:	5b                   	pop    %ebx
80104284:	5e                   	pop    %esi
80104285:	5f                   	pop    %edi
80104286:	5d                   	pop    %ebp
80104287:	c3                   	ret    
80104288:	90                   	nop
80104289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104290 <getNumProc>:
// My SYS CALLS
int getNumProc(void){
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	57                   	push   %edi
80104294:	56                   	push   %esi
80104295:	53                   	push   %ebx
80104296:	83 ec 38             	sub    $0x38,%esp
  asm volatile("sti");
80104299:	fb                   	sti    
	struct proc *p;
	int count=0;
	sti();
	acquire(&ptable.lock);
8010429a:	68 a0 2d 11 80       	push   $0x80112da0
	int count=0;
8010429f:	31 f6                	xor    %esi,%esi
  cprintf("NAME   PID   STATE   PRIORITY\n");
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042a1:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
801042a6:	8d 7d ca             	lea    -0x36(%ebp),%edi
	acquire(&ptable.lock);
801042a9:	e8 b2 02 00 00       	call   80104560 <acquire>
  cprintf("NAME   PID   STATE   PRIORITY\n");
801042ae:	c7 04 24 94 78 10 80 	movl   $0x80107894,(%esp)
801042b5:	e8 a6 c3 ff ff       	call   80100660 <cprintf>
801042ba:	83 c4 10             	add    $0x10,%esp
801042bd:	eb 4e                	jmp    8010430d <getNumProc+0x7d>
801042bf:	90                   	nop
      char state[30];
      if(p->state == EMBRYO){
        strncpy(state,"EMBROY",30);
      }

      if(p->state == SLEEPING){
801042c0:	83 f8 02             	cmp    $0x2,%eax
801042c3:	74 76                	je     8010433b <getNumProc+0xab>
        strncpy(state,"SLEEPING",30);
      }

      if(p->state == RUNNABLE){
801042c5:	83 f8 03             	cmp    $0x3,%eax
801042c8:	0f 84 8c 00 00 00    	je     8010435a <getNumProc+0xca>
        strncpy(state,"RUNNABLE",30);
      }

      if(p->state == RUNNING){
801042ce:	83 f8 04             	cmp    $0x4,%eax
801042d1:	0f 84 a2 00 00 00    	je     80104379 <getNumProc+0xe9>
        strncpy(state,"RUNNING",30);
      }

      if(p->state == ZOMBIE){
801042d7:	83 f8 05             	cmp    $0x5,%eax
801042da:	0f 84 b8 00 00 00    	je     80104398 <getNumProc+0x108>
        strncpy(state,"ZOMBIE",30);
        
      }
      cprintf("%s   %d   %s   %d\n",p->name,p->pid,state,p->priority);
801042e0:	8d 43 6c             	lea    0x6c(%ebx),%eax
801042e3:	83 ec 0c             	sub    $0xc,%esp
801042e6:	ff 73 7c             	pushl  0x7c(%ebx)
801042e9:	57                   	push   %edi
801042ea:	ff 73 10             	pushl  0x10(%ebx)
801042ed:	50                   	push   %eax
801042ee:	68 3d 78 10 80       	push   $0x8010783d
801042f3:	e8 68 c3 ff ff       	call   80100660 <cprintf>
801042f8:	83 c4 20             	add    $0x20,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042fb:	81 c3 84 00 00 00    	add    $0x84,%ebx
80104301:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80104307:	0f 83 a3 00 00 00    	jae    801043b0 <getNumProc+0x120>
		if(p->state == EMBRYO || p->state == SLEEPING || p->state == RUNNABLE || p->state == RUNNING || p->state == ZOMBIE){
8010430d:	8b 43 0c             	mov    0xc(%ebx),%eax
80104310:	8d 50 ff             	lea    -0x1(%eax),%edx
80104313:	83 fa 04             	cmp    $0x4,%edx
80104316:	77 e3                	ja     801042fb <getNumProc+0x6b>
			count++;
80104318:	83 c6 01             	add    $0x1,%esi
      if(p->state == EMBRYO){
8010431b:	83 f8 01             	cmp    $0x1,%eax
8010431e:	75 a0                	jne    801042c0 <getNumProc+0x30>
        strncpy(state,"EMBROY",30);
80104320:	83 ec 04             	sub    $0x4,%esp
80104323:	6a 1e                	push   $0x1e
80104325:	68 15 78 10 80       	push   $0x80107815
8010432a:	57                   	push   %edi
8010432b:	e8 e0 05 00 00       	call   80104910 <strncpy>
80104330:	8b 43 0c             	mov    0xc(%ebx),%eax
80104333:	83 c4 10             	add    $0x10,%esp
      if(p->state == SLEEPING){
80104336:	83 f8 02             	cmp    $0x2,%eax
80104339:	75 8a                	jne    801042c5 <getNumProc+0x35>
        strncpy(state,"SLEEPING",30);
8010433b:	83 ec 04             	sub    $0x4,%esp
8010433e:	6a 1e                	push   $0x1e
80104340:	68 1c 78 10 80       	push   $0x8010781c
80104345:	57                   	push   %edi
80104346:	e8 c5 05 00 00       	call   80104910 <strncpy>
8010434b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010434e:	83 c4 10             	add    $0x10,%esp
      if(p->state == RUNNABLE){
80104351:	83 f8 03             	cmp    $0x3,%eax
80104354:	0f 85 74 ff ff ff    	jne    801042ce <getNumProc+0x3e>
        strncpy(state,"RUNNABLE",30);
8010435a:	83 ec 04             	sub    $0x4,%esp
8010435d:	6a 1e                	push   $0x1e
8010435f:	68 25 78 10 80       	push   $0x80107825
80104364:	57                   	push   %edi
80104365:	e8 a6 05 00 00       	call   80104910 <strncpy>
8010436a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010436d:	83 c4 10             	add    $0x10,%esp
      if(p->state == RUNNING){
80104370:	83 f8 04             	cmp    $0x4,%eax
80104373:	0f 85 5e ff ff ff    	jne    801042d7 <getNumProc+0x47>
        strncpy(state,"RUNNING",30);
80104379:	83 ec 04             	sub    $0x4,%esp
8010437c:	6a 1e                	push   $0x1e
8010437e:	68 2e 78 10 80       	push   $0x8010782e
80104383:	57                   	push   %edi
80104384:	e8 87 05 00 00       	call   80104910 <strncpy>
80104389:	8b 43 0c             	mov    0xc(%ebx),%eax
8010438c:	83 c4 10             	add    $0x10,%esp
      if(p->state == ZOMBIE){
8010438f:	83 f8 05             	cmp    $0x5,%eax
80104392:	0f 85 48 ff ff ff    	jne    801042e0 <getNumProc+0x50>
        strncpy(state,"ZOMBIE",30);
80104398:	83 ec 04             	sub    $0x4,%esp
8010439b:	6a 1e                	push   $0x1e
8010439d:	68 36 78 10 80       	push   $0x80107836
801043a2:	57                   	push   %edi
801043a3:	e8 68 05 00 00       	call   80104910 <strncpy>
801043a8:	83 c4 10             	add    $0x10,%esp
801043ab:	e9 30 ff ff ff       	jmp    801042e0 <getNumProc+0x50>
		}
	}
	cprintf("No. of process is: %d\n",count);
801043b0:	83 ec 08             	sub    $0x8,%esp
801043b3:	56                   	push   %esi
801043b4:	68 50 78 10 80       	push   $0x80107850
801043b9:	e8 a2 c2 ff ff       	call   80100660 <cprintf>
	release(&ptable.lock);
801043be:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801043c5:	e8 56 03 00 00       	call   80104720 <release>
	return 22;	
}
801043ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043cd:	b8 16 00 00 00       	mov    $0x16,%eax
801043d2:	5b                   	pop    %ebx
801043d3:	5e                   	pop    %esi
801043d4:	5f                   	pop    %edi
801043d5:	5d                   	pop    %ebp
801043d6:	c3                   	ret    
801043d7:	89 f6                	mov    %esi,%esi
801043d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043e0 <chpr>:


//For Priority Inversion
int chpr( int pid, int priority )
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 10             	sub    $0x10,%esp
801043e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043ea:	fb                   	sti    
  struct proc *p;
  sti();
  acquire(&ptable.lock);
801043eb:	68 a0 2d 11 80       	push   $0x80112da0
801043f0:	e8 6b 01 00 00       	call   80104560 <acquire>
801043f5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043f8:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
801043fd:	eb 0f                	jmp    8010440e <chpr+0x2e>
801043ff:	90                   	nop
80104400:	81 c2 84 00 00 00    	add    $0x84,%edx
80104406:	81 fa d4 4e 11 80    	cmp    $0x80114ed4,%edx
8010440c:	73 0b                	jae    80104419 <chpr+0x39>
    if(p->pid == pid ) {
8010440e:	39 5a 10             	cmp    %ebx,0x10(%edx)
80104411:	75 ed                	jne    80104400 <chpr+0x20>
        p->priority = priority;
80104413:	8b 45 0c             	mov    0xc(%ebp),%eax
80104416:	89 42 7c             	mov    %eax,0x7c(%edx)
        break;
    }
  }
  release(&ptable.lock);
80104419:	83 ec 0c             	sub    $0xc,%esp
8010441c:	68 a0 2d 11 80       	push   $0x80112da0
80104421:	e8 fa 02 00 00       	call   80104720 <release>

  return pid;
}
80104426:	89 d8                	mov    %ebx,%eax
80104428:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010442b:	c9                   	leave  
8010442c:	c3                   	ret    
8010442d:	66 90                	xchg   %ax,%ax
8010442f:	90                   	nop

80104430 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	53                   	push   %ebx
80104434:	83 ec 0c             	sub    $0xc,%esp
80104437:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010443a:	68 cc 78 10 80       	push   $0x801078cc
8010443f:	8d 43 04             	lea    0x4(%ebx),%eax
80104442:	50                   	push   %eax
80104443:	e8 f8 00 00 00       	call   80104540 <initlock>
  lk->name = name;
80104448:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010444b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104451:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104454:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010445b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010445e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104461:	c9                   	leave  
80104462:	c3                   	ret    
80104463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104470 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	56                   	push   %esi
80104474:	53                   	push   %ebx
80104475:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104478:	83 ec 0c             	sub    $0xc,%esp
8010447b:	8d 73 04             	lea    0x4(%ebx),%esi
8010447e:	56                   	push   %esi
8010447f:	e8 dc 00 00 00       	call   80104560 <acquire>
  while (lk->locked) {
80104484:	8b 13                	mov    (%ebx),%edx
80104486:	83 c4 10             	add    $0x10,%esp
80104489:	85 d2                	test   %edx,%edx
8010448b:	74 16                	je     801044a3 <acquiresleep+0x33>
8010448d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104490:	83 ec 08             	sub    $0x8,%esp
80104493:	56                   	push   %esi
80104494:	53                   	push   %ebx
80104495:	e8 96 fa ff ff       	call   80103f30 <sleep>
  while (lk->locked) {
8010449a:	8b 03                	mov    (%ebx),%eax
8010449c:	83 c4 10             	add    $0x10,%esp
8010449f:	85 c0                	test   %eax,%eax
801044a1:	75 ed                	jne    80104490 <acquiresleep+0x20>
  }
  lk->locked = 1;
801044a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
801044a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044af:	8b 40 10             	mov    0x10(%eax),%eax
801044b2:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801044b5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801044b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044bb:	5b                   	pop    %ebx
801044bc:	5e                   	pop    %esi
801044bd:	5d                   	pop    %ebp
  release(&lk->lk);
801044be:	e9 5d 02 00 00       	jmp    80104720 <release>
801044c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	56                   	push   %esi
801044d4:	53                   	push   %ebx
801044d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801044d8:	83 ec 0c             	sub    $0xc,%esp
801044db:	8d 73 04             	lea    0x4(%ebx),%esi
801044de:	56                   	push   %esi
801044df:	e8 7c 00 00 00       	call   80104560 <acquire>
  lk->locked = 0;
801044e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801044ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801044f1:	89 1c 24             	mov    %ebx,(%esp)
801044f4:	e8 e7 fb ff ff       	call   801040e0 <wakeup>
  release(&lk->lk);
801044f9:	89 75 08             	mov    %esi,0x8(%ebp)
801044fc:	83 c4 10             	add    $0x10,%esp
}
801044ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104502:	5b                   	pop    %ebx
80104503:	5e                   	pop    %esi
80104504:	5d                   	pop    %ebp
  release(&lk->lk);
80104505:	e9 16 02 00 00       	jmp    80104720 <release>
8010450a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104510 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	56                   	push   %esi
80104514:	53                   	push   %ebx
80104515:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104518:	83 ec 0c             	sub    $0xc,%esp
8010451b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010451e:	53                   	push   %ebx
8010451f:	e8 3c 00 00 00       	call   80104560 <acquire>
  r = lk->locked;
80104524:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104526:	89 1c 24             	mov    %ebx,(%esp)
80104529:	e8 f2 01 00 00       	call   80104720 <release>
  return r;
}
8010452e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104531:	89 f0                	mov    %esi,%eax
80104533:	5b                   	pop    %ebx
80104534:	5e                   	pop    %esi
80104535:	5d                   	pop    %ebp
80104536:	c3                   	ret    
80104537:	66 90                	xchg   %ax,%ax
80104539:	66 90                	xchg   %ax,%ax
8010453b:	66 90                	xchg   %ax,%ax
8010453d:	66 90                	xchg   %ax,%ax
8010453f:	90                   	nop

80104540 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104546:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104549:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010454f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104552:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104559:	5d                   	pop    %ebp
8010455a:	c3                   	ret    
8010455b:	90                   	nop
8010455c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104560 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	53                   	push   %ebx
80104564:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104567:	9c                   	pushf  
80104568:	5a                   	pop    %edx
  asm volatile("cli");
80104569:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
8010456a:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104571:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104577:	85 c0                	test   %eax,%eax
80104579:	75 0c                	jne    80104587 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
8010457b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104581:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
  if(holding(lk))
80104587:	8b 55 08             	mov    0x8(%ebp),%edx
  cpu->ncli += 1;
8010458a:	83 c0 01             	add    $0x1,%eax
8010458d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)
  return lock->locked && lock->cpu == cpu;
80104593:	8b 02                	mov    (%edx),%eax
80104595:	85 c0                	test   %eax,%eax
80104597:	74 05                	je     8010459e <acquire+0x3e>
80104599:	39 4a 08             	cmp    %ecx,0x8(%edx)
8010459c:	74 74                	je     80104612 <acquire+0xb2>
  asm volatile("lock; xchgl %0, %1" :
8010459e:	b9 01 00 00 00       	mov    $0x1,%ecx
801045a3:	90                   	nop
801045a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045a8:	89 c8                	mov    %ecx,%eax
801045aa:	f0 87 02             	lock xchg %eax,(%edx)
  while(xchg(&lk->locked, 1) != 0)
801045ad:	85 c0                	test   %eax,%eax
801045af:	75 f7                	jne    801045a8 <acquire+0x48>
  __sync_synchronize();
801045b1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = cpu;
801045b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801045b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  for(i = 0; i < 10; i++){
801045bf:	31 d2                	xor    %edx,%edx
  lk->cpu = cpu;
801045c1:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
801045c4:	83 c1 0c             	add    $0xc,%ecx
  ebp = (uint*)v - 2;
801045c7:	89 e8                	mov    %ebp,%eax
801045c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045d0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801045d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801045dc:	77 1a                	ja     801045f8 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
801045de:	8b 58 04             	mov    0x4(%eax),%ebx
801045e1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801045e4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801045e7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801045e9:	83 fa 0a             	cmp    $0xa,%edx
801045ec:	75 e2                	jne    801045d0 <acquire+0x70>
}
801045ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045f1:	c9                   	leave  
801045f2:	c3                   	ret    
801045f3:	90                   	nop
801045f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045f8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801045fb:	83 c1 28             	add    $0x28,%ecx
801045fe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104600:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104606:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104609:	39 c8                	cmp    %ecx,%eax
8010460b:	75 f3                	jne    80104600 <acquire+0xa0>
}
8010460d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104610:	c9                   	leave  
80104611:	c3                   	ret    
    panic("acquire");
80104612:	83 ec 0c             	sub    $0xc,%esp
80104615:	68 d7 78 10 80       	push   $0x801078d7
8010461a:	e8 71 bd ff ff       	call   80100390 <panic>
8010461f:	90                   	nop

80104620 <getcallerpcs>:
{
80104620:	55                   	push   %ebp
  for(i = 0; i < 10; i++){
80104621:	31 d2                	xor    %edx,%edx
{
80104623:	89 e5                	mov    %esp,%ebp
80104625:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104626:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104629:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010462c:	83 e8 08             	sub    $0x8,%eax
8010462f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104630:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104636:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010463c:	77 1a                	ja     80104658 <getcallerpcs+0x38>
    pcs[i] = ebp[1];     // saved %eip
8010463e:	8b 58 04             	mov    0x4(%eax),%ebx
80104641:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104644:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104647:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104649:	83 fa 0a             	cmp    $0xa,%edx
8010464c:	75 e2                	jne    80104630 <getcallerpcs+0x10>
}
8010464e:	5b                   	pop    %ebx
8010464f:	5d                   	pop    %ebp
80104650:	c3                   	ret    
80104651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104658:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010465b:	83 c1 28             	add    $0x28,%ecx
8010465e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104660:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104666:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104669:	39 c1                	cmp    %eax,%ecx
8010466b:	75 f3                	jne    80104660 <getcallerpcs+0x40>
}
8010466d:	5b                   	pop    %ebx
8010466e:	5d                   	pop    %ebp
8010466f:	c3                   	ret    

80104670 <holding>:
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104676:	8b 02                	mov    (%edx),%eax
80104678:	85 c0                	test   %eax,%eax
8010467a:	74 14                	je     80104690 <holding+0x20>
8010467c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104682:	39 42 08             	cmp    %eax,0x8(%edx)
}
80104685:	5d                   	pop    %ebp
  return lock->locked && lock->cpu == cpu;
80104686:	0f 94 c0             	sete   %al
80104689:	0f b6 c0             	movzbl %al,%eax
}
8010468c:	c3                   	ret    
8010468d:	8d 76 00             	lea    0x0(%esi),%esi
80104690:	31 c0                	xor    %eax,%eax
80104692:	5d                   	pop    %ebp
80104693:	c3                   	ret    
80104694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010469a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801046a0 <pushcli>:
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046a3:	9c                   	pushf  
801046a4:	59                   	pop    %ecx
  asm volatile("cli");
801046a5:	fa                   	cli    
  if(cpu->ncli == 0)
801046a6:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801046ad:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801046b3:	85 c0                	test   %eax,%eax
801046b5:	75 0c                	jne    801046c3 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
801046b7:	81 e1 00 02 00 00    	and    $0x200,%ecx
801046bd:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
801046c3:	83 c0 01             	add    $0x1,%eax
801046c6:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
801046cc:	5d                   	pop    %ebp
801046cd:	c3                   	ret    
801046ce:	66 90                	xchg   %ax,%ax

801046d0 <popcli>:

void
popcli(void)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046d6:	9c                   	pushf  
801046d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801046d8:	f6 c4 02             	test   $0x2,%ah
801046db:	75 2c                	jne    80104709 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801046dd:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801046e4:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
801046eb:	78 0f                	js     801046fc <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
801046ed:	75 0b                	jne    801046fa <popcli+0x2a>
801046ef:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
801046f5:	85 c0                	test   %eax,%eax
801046f7:	74 01                	je     801046fa <popcli+0x2a>
  asm volatile("sti");
801046f9:	fb                   	sti    
    sti();
}
801046fa:	c9                   	leave  
801046fb:	c3                   	ret    
    panic("popcli");
801046fc:	83 ec 0c             	sub    $0xc,%esp
801046ff:	68 f6 78 10 80       	push   $0x801078f6
80104704:	e8 87 bc ff ff       	call   80100390 <panic>
    panic("popcli - interruptible");
80104709:	83 ec 0c             	sub    $0xc,%esp
8010470c:	68 df 78 10 80       	push   $0x801078df
80104711:	e8 7a bc ff ff       	call   80100390 <panic>
80104716:	8d 76 00             	lea    0x0(%esi),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <release>:
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	83 ec 08             	sub    $0x8,%esp
80104726:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == cpu;
80104729:	8b 10                	mov    (%eax),%edx
8010472b:	85 d2                	test   %edx,%edx
8010472d:	74 2b                	je     8010475a <release+0x3a>
8010472f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104736:	39 50 08             	cmp    %edx,0x8(%eax)
80104739:	75 1f                	jne    8010475a <release+0x3a>
  lk->pcs[0] = 0;
8010473b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104742:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  __sync_synchronize();
80104749:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010474e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
80104754:	c9                   	leave  
  popcli();
80104755:	e9 76 ff ff ff       	jmp    801046d0 <popcli>
    panic("release");
8010475a:	83 ec 0c             	sub    $0xc,%esp
8010475d:	68 fd 78 10 80       	push   $0x801078fd
80104762:	e8 29 bc ff ff       	call   80100390 <panic>
80104767:	66 90                	xchg   %ax,%ax
80104769:	66 90                	xchg   %ax,%ax
8010476b:	66 90                	xchg   %ax,%ax
8010476d:	66 90                	xchg   %ax,%ax
8010476f:	90                   	nop

80104770 <memset>:
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	57                   	push   %edi
80104774:	53                   	push   %ebx
80104775:	8b 55 08             	mov    0x8(%ebp),%edx
80104778:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010477b:	f6 c2 03             	test   $0x3,%dl
8010477e:	75 05                	jne    80104785 <memset+0x15>
80104780:	f6 c1 03             	test   $0x3,%cl
80104783:	74 13                	je     80104798 <memset+0x28>
80104785:	89 d7                	mov    %edx,%edi
80104787:	8b 45 0c             	mov    0xc(%ebp),%eax
8010478a:	fc                   	cld    
8010478b:	f3 aa                	rep stos %al,%es:(%edi)
8010478d:	5b                   	pop    %ebx
8010478e:	89 d0                	mov    %edx,%eax
80104790:	5f                   	pop    %edi
80104791:	5d                   	pop    %ebp
80104792:	c3                   	ret    
80104793:	90                   	nop
80104794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104798:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
8010479c:	c1 e9 02             	shr    $0x2,%ecx
8010479f:	89 fb                	mov    %edi,%ebx
801047a1:	89 f8                	mov    %edi,%eax
801047a3:	c1 e3 18             	shl    $0x18,%ebx
801047a6:	c1 e0 10             	shl    $0x10,%eax
801047a9:	09 d8                	or     %ebx,%eax
801047ab:	09 f8                	or     %edi,%eax
801047ad:	c1 e7 08             	shl    $0x8,%edi
801047b0:	09 f8                	or     %edi,%eax
801047b2:	89 d7                	mov    %edx,%edi
801047b4:	fc                   	cld    
801047b5:	f3 ab                	rep stos %eax,%es:(%edi)
801047b7:	5b                   	pop    %ebx
801047b8:	89 d0                	mov    %edx,%eax
801047ba:	5f                   	pop    %edi
801047bb:	5d                   	pop    %ebp
801047bc:	c3                   	ret    
801047bd:	8d 76 00             	lea    0x0(%esi),%esi

801047c0 <memcmp>:
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	57                   	push   %edi
801047c4:	56                   	push   %esi
801047c5:	8b 45 10             	mov    0x10(%ebp),%eax
801047c8:	53                   	push   %ebx
801047c9:	8b 75 0c             	mov    0xc(%ebp),%esi
801047cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047cf:	85 c0                	test   %eax,%eax
801047d1:	74 29                	je     801047fc <memcmp+0x3c>
801047d3:	0f b6 13             	movzbl (%ebx),%edx
801047d6:	0f b6 0e             	movzbl (%esi),%ecx
801047d9:	38 d1                	cmp    %dl,%cl
801047db:	75 2b                	jne    80104808 <memcmp+0x48>
801047dd:	8d 78 ff             	lea    -0x1(%eax),%edi
801047e0:	31 c0                	xor    %eax,%eax
801047e2:	eb 14                	jmp    801047f8 <memcmp+0x38>
801047e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047e8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
801047ed:	83 c0 01             	add    $0x1,%eax
801047f0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801047f4:	38 ca                	cmp    %cl,%dl
801047f6:	75 10                	jne    80104808 <memcmp+0x48>
801047f8:	39 f8                	cmp    %edi,%eax
801047fa:	75 ec                	jne    801047e8 <memcmp+0x28>
801047fc:	5b                   	pop    %ebx
801047fd:	31 c0                	xor    %eax,%eax
801047ff:	5e                   	pop    %esi
80104800:	5f                   	pop    %edi
80104801:	5d                   	pop    %ebp
80104802:	c3                   	ret    
80104803:	90                   	nop
80104804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104808:	0f b6 c2             	movzbl %dl,%eax
8010480b:	5b                   	pop    %ebx
8010480c:	29 c8                	sub    %ecx,%eax
8010480e:	5e                   	pop    %esi
8010480f:	5f                   	pop    %edi
80104810:	5d                   	pop    %ebp
80104811:	c3                   	ret    
80104812:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <memmove>:
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	56                   	push   %esi
80104824:	53                   	push   %ebx
80104825:	8b 45 08             	mov    0x8(%ebp),%eax
80104828:	8b 75 0c             	mov    0xc(%ebp),%esi
8010482b:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010482e:	39 c6                	cmp    %eax,%esi
80104830:	73 2e                	jae    80104860 <memmove+0x40>
80104832:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104835:	39 c8                	cmp    %ecx,%eax
80104837:	73 27                	jae    80104860 <memmove+0x40>
80104839:	85 db                	test   %ebx,%ebx
8010483b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010483e:	74 17                	je     80104857 <memmove+0x37>
80104840:	29 d9                	sub    %ebx,%ecx
80104842:	89 cb                	mov    %ecx,%ebx
80104844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104848:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010484c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
8010484f:	83 ea 01             	sub    $0x1,%edx
80104852:	83 fa ff             	cmp    $0xffffffff,%edx
80104855:	75 f1                	jne    80104848 <memmove+0x28>
80104857:	5b                   	pop    %ebx
80104858:	5e                   	pop    %esi
80104859:	5d                   	pop    %ebp
8010485a:	c3                   	ret    
8010485b:	90                   	nop
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104860:	31 d2                	xor    %edx,%edx
80104862:	85 db                	test   %ebx,%ebx
80104864:	74 f1                	je     80104857 <memmove+0x37>
80104866:	8d 76 00             	lea    0x0(%esi),%esi
80104869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104870:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104874:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104877:	83 c2 01             	add    $0x1,%edx
8010487a:	39 d3                	cmp    %edx,%ebx
8010487c:	75 f2                	jne    80104870 <memmove+0x50>
8010487e:	5b                   	pop    %ebx
8010487f:	5e                   	pop    %esi
80104880:	5d                   	pop    %ebp
80104881:	c3                   	ret    
80104882:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104890 <memcpy>:
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	5d                   	pop    %ebp
80104894:	eb 8a                	jmp    80104820 <memmove>
80104896:	8d 76 00             	lea    0x0(%esi),%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048a0 <strncmp>:
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	57                   	push   %edi
801048a4:	56                   	push   %esi
801048a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048a8:	53                   	push   %ebx
801048a9:	8b 7d 08             	mov    0x8(%ebp),%edi
801048ac:	8b 75 0c             	mov    0xc(%ebp),%esi
801048af:	85 c9                	test   %ecx,%ecx
801048b1:	74 37                	je     801048ea <strncmp+0x4a>
801048b3:	0f b6 17             	movzbl (%edi),%edx
801048b6:	0f b6 1e             	movzbl (%esi),%ebx
801048b9:	84 d2                	test   %dl,%dl
801048bb:	74 3f                	je     801048fc <strncmp+0x5c>
801048bd:	38 d3                	cmp    %dl,%bl
801048bf:	75 3b                	jne    801048fc <strncmp+0x5c>
801048c1:	8d 47 01             	lea    0x1(%edi),%eax
801048c4:	01 cf                	add    %ecx,%edi
801048c6:	eb 1b                	jmp    801048e3 <strncmp+0x43>
801048c8:	90                   	nop
801048c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048d0:	0f b6 10             	movzbl (%eax),%edx
801048d3:	84 d2                	test   %dl,%dl
801048d5:	74 21                	je     801048f8 <strncmp+0x58>
801048d7:	0f b6 19             	movzbl (%ecx),%ebx
801048da:	83 c0 01             	add    $0x1,%eax
801048dd:	89 ce                	mov    %ecx,%esi
801048df:	38 da                	cmp    %bl,%dl
801048e1:	75 19                	jne    801048fc <strncmp+0x5c>
801048e3:	39 c7                	cmp    %eax,%edi
801048e5:	8d 4e 01             	lea    0x1(%esi),%ecx
801048e8:	75 e6                	jne    801048d0 <strncmp+0x30>
801048ea:	5b                   	pop    %ebx
801048eb:	31 c0                	xor    %eax,%eax
801048ed:	5e                   	pop    %esi
801048ee:	5f                   	pop    %edi
801048ef:	5d                   	pop    %ebp
801048f0:	c3                   	ret    
801048f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048f8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
801048fc:	0f b6 c2             	movzbl %dl,%eax
801048ff:	29 d8                	sub    %ebx,%eax
80104901:	5b                   	pop    %ebx
80104902:	5e                   	pop    %esi
80104903:	5f                   	pop    %edi
80104904:	5d                   	pop    %ebp
80104905:	c3                   	ret    
80104906:	8d 76 00             	lea    0x0(%esi),%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104910 <strncpy>:
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	56                   	push   %esi
80104914:	53                   	push   %ebx
80104915:	8b 45 08             	mov    0x8(%ebp),%eax
80104918:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010491b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010491e:	89 c2                	mov    %eax,%edx
80104920:	eb 19                	jmp    8010493b <strncpy+0x2b>
80104922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104928:	83 c3 01             	add    $0x1,%ebx
8010492b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010492f:	83 c2 01             	add    $0x1,%edx
80104932:	84 c9                	test   %cl,%cl
80104934:	88 4a ff             	mov    %cl,-0x1(%edx)
80104937:	74 09                	je     80104942 <strncpy+0x32>
80104939:	89 f1                	mov    %esi,%ecx
8010493b:	85 c9                	test   %ecx,%ecx
8010493d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104940:	7f e6                	jg     80104928 <strncpy+0x18>
80104942:	31 c9                	xor    %ecx,%ecx
80104944:	85 f6                	test   %esi,%esi
80104946:	7e 17                	jle    8010495f <strncpy+0x4f>
80104948:	90                   	nop
80104949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104950:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104954:	89 f3                	mov    %esi,%ebx
80104956:	83 c1 01             	add    $0x1,%ecx
80104959:	29 cb                	sub    %ecx,%ebx
8010495b:	85 db                	test   %ebx,%ebx
8010495d:	7f f1                	jg     80104950 <strncpy+0x40>
8010495f:	5b                   	pop    %ebx
80104960:	5e                   	pop    %esi
80104961:	5d                   	pop    %ebp
80104962:	c3                   	ret    
80104963:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104970 <safestrcpy>:
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
80104975:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104978:	8b 45 08             	mov    0x8(%ebp),%eax
8010497b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010497e:	85 c9                	test   %ecx,%ecx
80104980:	7e 26                	jle    801049a8 <safestrcpy+0x38>
80104982:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104986:	89 c1                	mov    %eax,%ecx
80104988:	eb 17                	jmp    801049a1 <safestrcpy+0x31>
8010498a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104990:	83 c2 01             	add    $0x1,%edx
80104993:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104997:	83 c1 01             	add    $0x1,%ecx
8010499a:	84 db                	test   %bl,%bl
8010499c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010499f:	74 04                	je     801049a5 <safestrcpy+0x35>
801049a1:	39 f2                	cmp    %esi,%edx
801049a3:	75 eb                	jne    80104990 <safestrcpy+0x20>
801049a5:	c6 01 00             	movb   $0x0,(%ecx)
801049a8:	5b                   	pop    %ebx
801049a9:	5e                   	pop    %esi
801049aa:	5d                   	pop    %ebp
801049ab:	c3                   	ret    
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049b0 <strlen>:
801049b0:	55                   	push   %ebp
801049b1:	31 c0                	xor    %eax,%eax
801049b3:	89 e5                	mov    %esp,%ebp
801049b5:	8b 55 08             	mov    0x8(%ebp),%edx
801049b8:	80 3a 00             	cmpb   $0x0,(%edx)
801049bb:	74 0c                	je     801049c9 <strlen+0x19>
801049bd:	8d 76 00             	lea    0x0(%esi),%esi
801049c0:	83 c0 01             	add    $0x1,%eax
801049c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801049c7:	75 f7                	jne    801049c0 <strlen+0x10>
801049c9:	5d                   	pop    %ebp
801049ca:	c3                   	ret    

801049cb <swtch>:
801049cb:	8b 44 24 04          	mov    0x4(%esp),%eax
801049cf:	8b 54 24 08          	mov    0x8(%esp),%edx
801049d3:	55                   	push   %ebp
801049d4:	53                   	push   %ebx
801049d5:	56                   	push   %esi
801049d6:	57                   	push   %edi
801049d7:	89 20                	mov    %esp,(%eax)
801049d9:	89 d4                	mov    %edx,%esp
801049db:	5f                   	pop    %edi
801049dc:	5e                   	pop    %esi
801049dd:	5b                   	pop    %ebx
801049de:	5d                   	pop    %ebp
801049df:	c3                   	ret    

801049e0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801049e0:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801049e1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
801049e8:	89 e5                	mov    %esp,%ebp
801049ea:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
801049ed:	8b 12                	mov    (%edx),%edx
801049ef:	39 c2                	cmp    %eax,%edx
801049f1:	76 15                	jbe    80104a08 <fetchint+0x28>
801049f3:	8d 48 04             	lea    0x4(%eax),%ecx
801049f6:	39 ca                	cmp    %ecx,%edx
801049f8:	72 0e                	jb     80104a08 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
801049fa:	8b 10                	mov    (%eax),%edx
801049fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ff:	89 10                	mov    %edx,(%eax)
  return 0;
80104a01:	31 c0                	xor    %eax,%eax
}
80104a03:	5d                   	pop    %ebp
80104a04:	c3                   	ret    
80104a05:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104a08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a0d:	5d                   	pop    %ebp
80104a0e:	c3                   	ret    
80104a0f:	90                   	nop

80104a10 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104a10:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104a11:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80104a17:	89 e5                	mov    %esp,%ebp
80104a19:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz)
80104a1c:	39 08                	cmp    %ecx,(%eax)
80104a1e:	76 2c                	jbe    80104a4c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104a20:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a23:	89 c8                	mov    %ecx,%eax
80104a25:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104a27:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a2e:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104a30:	39 d1                	cmp    %edx,%ecx
80104a32:	73 18                	jae    80104a4c <fetchstr+0x3c>
    if(*s == 0)
80104a34:	80 39 00             	cmpb   $0x0,(%ecx)
80104a37:	75 0c                	jne    80104a45 <fetchstr+0x35>
80104a39:	eb 25                	jmp    80104a60 <fetchstr+0x50>
80104a3b:	90                   	nop
80104a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a40:	80 38 00             	cmpb   $0x0,(%eax)
80104a43:	74 13                	je     80104a58 <fetchstr+0x48>
  for(s = *pp; s < ep; s++)
80104a45:	83 c0 01             	add    $0x1,%eax
80104a48:	39 c2                	cmp    %eax,%edx
80104a4a:	77 f4                	ja     80104a40 <fetchstr+0x30>
    return -1;
80104a4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  return -1;
}
80104a51:	5d                   	pop    %ebp
80104a52:	c3                   	ret    
80104a53:	90                   	nop
80104a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a58:	29 c8                	sub    %ecx,%eax
80104a5a:	5d                   	pop    %ebp
80104a5b:	c3                   	ret    
80104a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
80104a60:	31 c0                	xor    %eax,%eax
}
80104a62:	5d                   	pop    %ebp
80104a63:	c3                   	ret    
80104a64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a70 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a70:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80104a77:	55                   	push   %ebp
80104a78:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a7a:	8b 42 18             	mov    0x18(%edx),%eax
80104a7d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a80:	8b 12                	mov    (%edx),%edx
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a82:	8b 40 44             	mov    0x44(%eax),%eax
80104a85:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104a88:	8d 48 04             	lea    0x4(%eax),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a8b:	39 d1                	cmp    %edx,%ecx
80104a8d:	73 19                	jae    80104aa8 <argint+0x38>
80104a8f:	8d 48 08             	lea    0x8(%eax),%ecx
80104a92:	39 ca                	cmp    %ecx,%edx
80104a94:	72 12                	jb     80104aa8 <argint+0x38>
  *ip = *(int*)(addr);
80104a96:	8b 50 04             	mov    0x4(%eax),%edx
80104a99:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a9c:	89 10                	mov    %edx,(%eax)
  return 0;
80104a9e:	31 c0                	xor    %eax,%eax
}
80104aa0:	5d                   	pop    %ebp
80104aa1:	c3                   	ret    
80104aa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104aa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104aad:	5d                   	pop    %ebp
80104aae:	c3                   	ret    
80104aaf:	90                   	nop

80104ab0 <argptr>:
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104ab0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104ab6:	55                   	push   %ebp
80104ab7:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104ab9:	8b 50 18             	mov    0x18(%eax),%edx
80104abc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104abf:	8b 00                	mov    (%eax),%eax
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104ac1:	8b 52 44             	mov    0x44(%edx),%edx
80104ac4:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104ac7:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104aca:	39 c1                	cmp    %eax,%ecx
80104acc:	73 22                	jae    80104af0 <argptr+0x40>
80104ace:	8d 4a 08             	lea    0x8(%edx),%ecx
80104ad1:	39 c8                	cmp    %ecx,%eax
80104ad3:	72 1b                	jb     80104af0 <argptr+0x40>
  *ip = *(int*)(addr);
80104ad5:	8b 52 04             	mov    0x4(%edx),%edx
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80104ad8:	39 c2                	cmp    %eax,%edx
80104ada:	73 14                	jae    80104af0 <argptr+0x40>
80104adc:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104adf:	01 d1                	add    %edx,%ecx
80104ae1:	39 c1                	cmp    %eax,%ecx
80104ae3:	77 0b                	ja     80104af0 <argptr+0x40>
    return -1;
  *pp = (char*)i;
80104ae5:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ae8:	89 10                	mov    %edx,(%eax)
  return 0;
80104aea:	31 c0                	xor    %eax,%eax
}
80104aec:	5d                   	pop    %ebp
80104aed:	c3                   	ret    
80104aee:	66 90                	xchg   %ax,%ax
    return -1;
80104af0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104af5:	5d                   	pop    %ebp
80104af6:	c3                   	ret    
80104af7:	89 f6                	mov    %esi,%esi
80104af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b00 <argstr>:
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104b00:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104b06:	55                   	push   %ebp
80104b07:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104b09:	8b 50 18             	mov    0x18(%eax),%edx
80104b0c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104b0f:	8b 00                	mov    (%eax),%eax
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104b11:	8b 52 44             	mov    0x44(%edx),%edx
80104b14:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104b17:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104b1a:	39 c1                	cmp    %eax,%ecx
80104b1c:	73 3e                	jae    80104b5c <argstr+0x5c>
80104b1e:	8d 4a 08             	lea    0x8(%edx),%ecx
80104b21:	39 c8                	cmp    %ecx,%eax
80104b23:	72 37                	jb     80104b5c <argstr+0x5c>
  *ip = *(int*)(addr);
80104b25:	8b 4a 04             	mov    0x4(%edx),%ecx
  if(addr >= proc->sz)
80104b28:	39 c1                	cmp    %eax,%ecx
80104b2a:	73 30                	jae    80104b5c <argstr+0x5c>
  *pp = (char*)addr;
80104b2c:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b2f:	89 c8                	mov    %ecx,%eax
80104b31:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104b33:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b3a:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104b3c:	39 d1                	cmp    %edx,%ecx
80104b3e:	73 1c                	jae    80104b5c <argstr+0x5c>
    if(*s == 0)
80104b40:	80 39 00             	cmpb   $0x0,(%ecx)
80104b43:	75 10                	jne    80104b55 <argstr+0x55>
80104b45:	eb 29                	jmp    80104b70 <argstr+0x70>
80104b47:	89 f6                	mov    %esi,%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b50:	80 38 00             	cmpb   $0x0,(%eax)
80104b53:	74 13                	je     80104b68 <argstr+0x68>
  for(s = *pp; s < ep; s++)
80104b55:	83 c0 01             	add    $0x1,%eax
80104b58:	39 c2                	cmp    %eax,%edx
80104b5a:	77 f4                	ja     80104b50 <argstr+0x50>
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104b5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104b61:	5d                   	pop    %ebp
80104b62:	c3                   	ret    
80104b63:	90                   	nop
80104b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b68:	29 c8                	sub    %ecx,%eax
80104b6a:	5d                   	pop    %ebp
80104b6b:	c3                   	ret    
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
80104b70:	31 c0                	xor    %eax,%eax
}
80104b72:	5d                   	pop    %ebp
80104b73:	c3                   	ret    
80104b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b80 <syscall>:
[SYS_chpr]         sys_chpr, 
};

void
syscall(void)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	83 ec 08             	sub    $0x8,%esp
  int num;

  num = proc->tf->eax;
80104b86:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b8d:	8b 42 18             	mov    0x18(%edx),%eax
80104b90:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104b93:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104b96:	83 f9 16             	cmp    $0x16,%ecx
80104b99:	77 25                	ja     80104bc0 <syscall+0x40>
80104b9b:	8b 0c 85 40 79 10 80 	mov    -0x7fef86c0(,%eax,4),%ecx
80104ba2:	85 c9                	test   %ecx,%ecx
80104ba4:	74 1a                	je     80104bc0 <syscall+0x40>
    proc->tf->eax = syscalls[num]();
80104ba6:	ff d1                	call   *%ecx
80104ba8:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104baf:	8b 52 18             	mov    0x18(%edx),%edx
80104bb2:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104bb5:	c9                   	leave  
80104bb6:	c3                   	ret    
80104bb7:	89 f6                	mov    %esi,%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("%d %s: unknown sys call %d\n",
80104bc0:	50                   	push   %eax
            proc->pid, proc->name, num);
80104bc1:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104bc4:	50                   	push   %eax
80104bc5:	ff 72 10             	pushl  0x10(%edx)
80104bc8:	68 05 79 10 80       	push   $0x80107905
80104bcd:	e8 8e ba ff ff       	call   80100660 <cprintf>
    proc->tf->eax = -1;
80104bd2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bd8:	83 c4 10             	add    $0x10,%esp
80104bdb:	8b 40 18             	mov    0x18(%eax),%eax
80104bde:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104be5:	c9                   	leave  
80104be6:	c3                   	ret    
80104be7:	66 90                	xchg   %ax,%ax
80104be9:	66 90                	xchg   %ax,%ax
80104beb:	66 90                	xchg   %ax,%ax
80104bed:	66 90                	xchg   %ax,%ax
80104bef:	90                   	nop

80104bf0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	57                   	push   %edi
80104bf4:	56                   	push   %esi
80104bf5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104bf6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104bf9:	83 ec 44             	sub    $0x44,%esp
80104bfc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104bff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104c02:	56                   	push   %esi
80104c03:	50                   	push   %eax
{
80104c04:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104c07:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104c0a:	e8 d1 d2 ff ff       	call   80101ee0 <nameiparent>
80104c0f:	83 c4 10             	add    $0x10,%esp
80104c12:	85 c0                	test   %eax,%eax
80104c14:	0f 84 46 01 00 00    	je     80104d60 <create+0x170>
    return 0;
  ilock(dp);
80104c1a:	83 ec 0c             	sub    $0xc,%esp
80104c1d:	89 c3                	mov    %eax,%ebx
80104c1f:	50                   	push   %eax
80104c20:	e8 5b ca ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104c25:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104c28:	83 c4 0c             	add    $0xc,%esp
80104c2b:	50                   	push   %eax
80104c2c:	56                   	push   %esi
80104c2d:	53                   	push   %ebx
80104c2e:	e8 5d cf ff ff       	call   80101b90 <dirlookup>
80104c33:	83 c4 10             	add    $0x10,%esp
80104c36:	85 c0                	test   %eax,%eax
80104c38:	89 c7                	mov    %eax,%edi
80104c3a:	74 34                	je     80104c70 <create+0x80>
    iunlockput(dp);
80104c3c:	83 ec 0c             	sub    $0xc,%esp
80104c3f:	53                   	push   %ebx
80104c40:	e8 ab cc ff ff       	call   801018f0 <iunlockput>
    ilock(ip);
80104c45:	89 3c 24             	mov    %edi,(%esp)
80104c48:	e8 33 ca ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104c4d:	83 c4 10             	add    $0x10,%esp
80104c50:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104c55:	0f 85 95 00 00 00    	jne    80104cf0 <create+0x100>
80104c5b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104c60:	0f 85 8a 00 00 00    	jne    80104cf0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c69:	89 f8                	mov    %edi,%eax
80104c6b:	5b                   	pop    %ebx
80104c6c:	5e                   	pop    %esi
80104c6d:	5f                   	pop    %edi
80104c6e:	5d                   	pop    %ebp
80104c6f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104c70:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104c74:	83 ec 08             	sub    $0x8,%esp
80104c77:	50                   	push   %eax
80104c78:	ff 33                	pushl  (%ebx)
80104c7a:	e8 91 c8 ff ff       	call   80101510 <ialloc>
80104c7f:	83 c4 10             	add    $0x10,%esp
80104c82:	85 c0                	test   %eax,%eax
80104c84:	89 c7                	mov    %eax,%edi
80104c86:	0f 84 e8 00 00 00    	je     80104d74 <create+0x184>
  ilock(ip);
80104c8c:	83 ec 0c             	sub    $0xc,%esp
80104c8f:	50                   	push   %eax
80104c90:	e8 eb c9 ff ff       	call   80101680 <ilock>
  ip->major = major;
80104c95:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104c99:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104c9d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104ca1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104ca5:	b8 01 00 00 00       	mov    $0x1,%eax
80104caa:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104cae:	89 3c 24             	mov    %edi,(%esp)
80104cb1:	e8 1a c9 ff ff       	call   801015d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104cb6:	83 c4 10             	add    $0x10,%esp
80104cb9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104cbe:	74 50                	je     80104d10 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104cc0:	83 ec 04             	sub    $0x4,%esp
80104cc3:	ff 77 04             	pushl  0x4(%edi)
80104cc6:	56                   	push   %esi
80104cc7:	53                   	push   %ebx
80104cc8:	e8 33 d1 ff ff       	call   80101e00 <dirlink>
80104ccd:	83 c4 10             	add    $0x10,%esp
80104cd0:	85 c0                	test   %eax,%eax
80104cd2:	0f 88 8f 00 00 00    	js     80104d67 <create+0x177>
  iunlockput(dp);
80104cd8:	83 ec 0c             	sub    $0xc,%esp
80104cdb:	53                   	push   %ebx
80104cdc:	e8 0f cc ff ff       	call   801018f0 <iunlockput>
  return ip;
80104ce1:	83 c4 10             	add    $0x10,%esp
}
80104ce4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ce7:	89 f8                	mov    %edi,%eax
80104ce9:	5b                   	pop    %ebx
80104cea:	5e                   	pop    %esi
80104ceb:	5f                   	pop    %edi
80104cec:	5d                   	pop    %ebp
80104ced:	c3                   	ret    
80104cee:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104cf0:	83 ec 0c             	sub    $0xc,%esp
80104cf3:	57                   	push   %edi
    return 0;
80104cf4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104cf6:	e8 f5 cb ff ff       	call   801018f0 <iunlockput>
    return 0;
80104cfb:	83 c4 10             	add    $0x10,%esp
}
80104cfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d01:	89 f8                	mov    %edi,%eax
80104d03:	5b                   	pop    %ebx
80104d04:	5e                   	pop    %esi
80104d05:	5f                   	pop    %edi
80104d06:	5d                   	pop    %ebp
80104d07:	c3                   	ret    
80104d08:	90                   	nop
80104d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104d10:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104d15:	83 ec 0c             	sub    $0xc,%esp
80104d18:	53                   	push   %ebx
80104d19:	e8 b2 c8 ff ff       	call   801015d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104d1e:	83 c4 0c             	add    $0xc,%esp
80104d21:	ff 77 04             	pushl  0x4(%edi)
80104d24:	68 bc 79 10 80       	push   $0x801079bc
80104d29:	57                   	push   %edi
80104d2a:	e8 d1 d0 ff ff       	call   80101e00 <dirlink>
80104d2f:	83 c4 10             	add    $0x10,%esp
80104d32:	85 c0                	test   %eax,%eax
80104d34:	78 1c                	js     80104d52 <create+0x162>
80104d36:	83 ec 04             	sub    $0x4,%esp
80104d39:	ff 73 04             	pushl  0x4(%ebx)
80104d3c:	68 bb 79 10 80       	push   $0x801079bb
80104d41:	57                   	push   %edi
80104d42:	e8 b9 d0 ff ff       	call   80101e00 <dirlink>
80104d47:	83 c4 10             	add    $0x10,%esp
80104d4a:	85 c0                	test   %eax,%eax
80104d4c:	0f 89 6e ff ff ff    	jns    80104cc0 <create+0xd0>
      panic("create dots");
80104d52:	83 ec 0c             	sub    $0xc,%esp
80104d55:	68 af 79 10 80       	push   $0x801079af
80104d5a:	e8 31 b6 ff ff       	call   80100390 <panic>
80104d5f:	90                   	nop
    return 0;
80104d60:	31 ff                	xor    %edi,%edi
80104d62:	e9 ff fe ff ff       	jmp    80104c66 <create+0x76>
    panic("create: dirlink");
80104d67:	83 ec 0c             	sub    $0xc,%esp
80104d6a:	68 be 79 10 80       	push   $0x801079be
80104d6f:	e8 1c b6 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104d74:	83 ec 0c             	sub    $0xc,%esp
80104d77:	68 a0 79 10 80       	push   $0x801079a0
80104d7c:	e8 0f b6 ff ff       	call   80100390 <panic>
80104d81:	eb 0d                	jmp    80104d90 <argfd.constprop.0>
80104d83:	90                   	nop
80104d84:	90                   	nop
80104d85:	90                   	nop
80104d86:	90                   	nop
80104d87:	90                   	nop
80104d88:	90                   	nop
80104d89:	90                   	nop
80104d8a:	90                   	nop
80104d8b:	90                   	nop
80104d8c:	90                   	nop
80104d8d:	90                   	nop
80104d8e:	90                   	nop
80104d8f:	90                   	nop

80104d90 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	56                   	push   %esi
80104d94:	53                   	push   %ebx
80104d95:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104d97:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104d9a:	89 d6                	mov    %edx,%esi
80104d9c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104d9f:	50                   	push   %eax
80104da0:	6a 00                	push   $0x0
80104da2:	e8 c9 fc ff ff       	call   80104a70 <argint>
80104da7:	83 c4 10             	add    $0x10,%esp
80104daa:	85 c0                	test   %eax,%eax
80104dac:	78 32                	js     80104de0 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104dae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104db1:	83 f8 0f             	cmp    $0xf,%eax
80104db4:	77 2a                	ja     80104de0 <argfd.constprop.0+0x50>
80104db6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104dbd:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
80104dc1:	85 c9                	test   %ecx,%ecx
80104dc3:	74 1b                	je     80104de0 <argfd.constprop.0+0x50>
  if(pfd)
80104dc5:	85 db                	test   %ebx,%ebx
80104dc7:	74 02                	je     80104dcb <argfd.constprop.0+0x3b>
    *pfd = fd;
80104dc9:	89 03                	mov    %eax,(%ebx)
    *pf = f;
80104dcb:	89 0e                	mov    %ecx,(%esi)
  return 0;
80104dcd:	31 c0                	xor    %eax,%eax
}
80104dcf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dd2:	5b                   	pop    %ebx
80104dd3:	5e                   	pop    %esi
80104dd4:	5d                   	pop    %ebp
80104dd5:	c3                   	ret    
80104dd6:	8d 76 00             	lea    0x0(%esi),%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104de5:	eb e8                	jmp    80104dcf <argfd.constprop.0+0x3f>
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104df0 <sys_dup>:
{
80104df0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104df1:	31 c0                	xor    %eax,%eax
{
80104df3:	89 e5                	mov    %esp,%ebp
80104df5:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104df6:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104df9:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
80104dfc:	e8 8f ff ff ff       	call   80104d90 <argfd.constprop.0>
80104e01:	85 c0                	test   %eax,%eax
80104e03:	78 3b                	js     80104e40 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80104e05:	8b 55 f4             	mov    -0xc(%ebp),%edx
    if(proc->ofile[fd] == 0){
80104e08:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
80104e0e:	31 db                	xor    %ebx,%ebx
80104e10:	eb 0e                	jmp    80104e20 <sys_dup+0x30>
80104e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e18:	83 c3 01             	add    $0x1,%ebx
80104e1b:	83 fb 10             	cmp    $0x10,%ebx
80104e1e:	74 20                	je     80104e40 <sys_dup+0x50>
    if(proc->ofile[fd] == 0){
80104e20:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104e24:	85 c9                	test   %ecx,%ecx
80104e26:	75 f0                	jne    80104e18 <sys_dup+0x28>
  filedup(f);
80104e28:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80104e2b:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  filedup(f);
80104e2f:	52                   	push   %edx
80104e30:	e8 ab bf ff ff       	call   80100de0 <filedup>
}
80104e35:	89 d8                	mov    %ebx,%eax
  return fd;
80104e37:	83 c4 10             	add    $0x10,%esp
}
80104e3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e3d:	c9                   	leave  
80104e3e:	c3                   	ret    
80104e3f:	90                   	nop
    return -1;
80104e40:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104e45:	89 d8                	mov    %ebx,%eax
80104e47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e4a:	c9                   	leave  
80104e4b:	c3                   	ret    
80104e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e50 <sys_read>:
{
80104e50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e51:	31 c0                	xor    %eax,%eax
{
80104e53:	89 e5                	mov    %esp,%ebp
80104e55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e5b:	e8 30 ff ff ff       	call   80104d90 <argfd.constprop.0>
80104e60:	85 c0                	test   %eax,%eax
80104e62:	78 4c                	js     80104eb0 <sys_read+0x60>
80104e64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e67:	83 ec 08             	sub    $0x8,%esp
80104e6a:	50                   	push   %eax
80104e6b:	6a 02                	push   $0x2
80104e6d:	e8 fe fb ff ff       	call   80104a70 <argint>
80104e72:	83 c4 10             	add    $0x10,%esp
80104e75:	85 c0                	test   %eax,%eax
80104e77:	78 37                	js     80104eb0 <sys_read+0x60>
80104e79:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e7c:	83 ec 04             	sub    $0x4,%esp
80104e7f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e82:	50                   	push   %eax
80104e83:	6a 01                	push   $0x1
80104e85:	e8 26 fc ff ff       	call   80104ab0 <argptr>
80104e8a:	83 c4 10             	add    $0x10,%esp
80104e8d:	85 c0                	test   %eax,%eax
80104e8f:	78 1f                	js     80104eb0 <sys_read+0x60>
  return fileread(f, p, n);
80104e91:	83 ec 04             	sub    $0x4,%esp
80104e94:	ff 75 f0             	pushl  -0x10(%ebp)
80104e97:	ff 75 f4             	pushl  -0xc(%ebp)
80104e9a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e9d:	e8 ae c0 ff ff       	call   80100f50 <fileread>
80104ea2:	83 c4 10             	add    $0x10,%esp
}
80104ea5:	c9                   	leave  
80104ea6:	c3                   	ret    
80104ea7:	89 f6                	mov    %esi,%esi
80104ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104eb5:	c9                   	leave  
80104eb6:	c3                   	ret    
80104eb7:	89 f6                	mov    %esi,%esi
80104eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ec0 <sys_write>:
{
80104ec0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ec1:	31 c0                	xor    %eax,%eax
{
80104ec3:	89 e5                	mov    %esp,%ebp
80104ec5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ec8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ecb:	e8 c0 fe ff ff       	call   80104d90 <argfd.constprop.0>
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	78 4c                	js     80104f20 <sys_write+0x60>
80104ed4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ed7:	83 ec 08             	sub    $0x8,%esp
80104eda:	50                   	push   %eax
80104edb:	6a 02                	push   $0x2
80104edd:	e8 8e fb ff ff       	call   80104a70 <argint>
80104ee2:	83 c4 10             	add    $0x10,%esp
80104ee5:	85 c0                	test   %eax,%eax
80104ee7:	78 37                	js     80104f20 <sys_write+0x60>
80104ee9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eec:	83 ec 04             	sub    $0x4,%esp
80104eef:	ff 75 f0             	pushl  -0x10(%ebp)
80104ef2:	50                   	push   %eax
80104ef3:	6a 01                	push   $0x1
80104ef5:	e8 b6 fb ff ff       	call   80104ab0 <argptr>
80104efa:	83 c4 10             	add    $0x10,%esp
80104efd:	85 c0                	test   %eax,%eax
80104eff:	78 1f                	js     80104f20 <sys_write+0x60>
  return filewrite(f, p, n);
80104f01:	83 ec 04             	sub    $0x4,%esp
80104f04:	ff 75 f0             	pushl  -0x10(%ebp)
80104f07:	ff 75 f4             	pushl  -0xc(%ebp)
80104f0a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f0d:	e8 ce c0 ff ff       	call   80100fe0 <filewrite>
80104f12:	83 c4 10             	add    $0x10,%esp
}
80104f15:	c9                   	leave  
80104f16:	c3                   	ret    
80104f17:	89 f6                	mov    %esi,%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f25:	c9                   	leave  
80104f26:	c3                   	ret    
80104f27:	89 f6                	mov    %esi,%esi
80104f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f30 <sys_close>:
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104f36:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104f39:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f3c:	e8 4f fe ff ff       	call   80104d90 <argfd.constprop.0>
80104f41:	85 c0                	test   %eax,%eax
80104f43:	78 2b                	js     80104f70 <sys_close+0x40>
  proc->ofile[fd] = 0;
80104f45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f4b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104f4e:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
80104f51:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104f58:	00 
  fileclose(f);
80104f59:	ff 75 f4             	pushl  -0xc(%ebp)
80104f5c:	e8 cf be ff ff       	call   80100e30 <fileclose>
  return 0;
80104f61:	83 c4 10             	add    $0x10,%esp
80104f64:	31 c0                	xor    %eax,%eax
}
80104f66:	c9                   	leave  
80104f67:	c3                   	ret    
80104f68:	90                   	nop
80104f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f75:	c9                   	leave  
80104f76:	c3                   	ret    
80104f77:	89 f6                	mov    %esi,%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f80 <sys_fstat>:
{
80104f80:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f81:	31 c0                	xor    %eax,%eax
{
80104f83:	89 e5                	mov    %esp,%ebp
80104f85:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f88:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104f8b:	e8 00 fe ff ff       	call   80104d90 <argfd.constprop.0>
80104f90:	85 c0                	test   %eax,%eax
80104f92:	78 2c                	js     80104fc0 <sys_fstat+0x40>
80104f94:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f97:	83 ec 04             	sub    $0x4,%esp
80104f9a:	6a 14                	push   $0x14
80104f9c:	50                   	push   %eax
80104f9d:	6a 01                	push   $0x1
80104f9f:	e8 0c fb ff ff       	call   80104ab0 <argptr>
80104fa4:	83 c4 10             	add    $0x10,%esp
80104fa7:	85 c0                	test   %eax,%eax
80104fa9:	78 15                	js     80104fc0 <sys_fstat+0x40>
  return filestat(f, st);
80104fab:	83 ec 08             	sub    $0x8,%esp
80104fae:	ff 75 f4             	pushl  -0xc(%ebp)
80104fb1:	ff 75 f0             	pushl  -0x10(%ebp)
80104fb4:	e8 47 bf ff ff       	call   80100f00 <filestat>
80104fb9:	83 c4 10             	add    $0x10,%esp
}
80104fbc:	c9                   	leave  
80104fbd:	c3                   	ret    
80104fbe:	66 90                	xchg   %ax,%ax
    return -1;
80104fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fc5:	c9                   	leave  
80104fc6:	c3                   	ret    
80104fc7:	89 f6                	mov    %esi,%esi
80104fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fd0 <sys_link>:
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	57                   	push   %edi
80104fd4:	56                   	push   %esi
80104fd5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fd6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104fd9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fdc:	50                   	push   %eax
80104fdd:	6a 00                	push   $0x0
80104fdf:	e8 1c fb ff ff       	call   80104b00 <argstr>
80104fe4:	83 c4 10             	add    $0x10,%esp
80104fe7:	85 c0                	test   %eax,%eax
80104fe9:	0f 88 fb 00 00 00    	js     801050ea <sys_link+0x11a>
80104fef:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104ff2:	83 ec 08             	sub    $0x8,%esp
80104ff5:	50                   	push   %eax
80104ff6:	6a 01                	push   $0x1
80104ff8:	e8 03 fb ff ff       	call   80104b00 <argstr>
80104ffd:	83 c4 10             	add    $0x10,%esp
80105000:	85 c0                	test   %eax,%eax
80105002:	0f 88 e2 00 00 00    	js     801050ea <sys_link+0x11a>
  begin_op();
80105008:	e8 33 dc ff ff       	call   80102c40 <begin_op>
  if((ip = namei(old)) == 0){
8010500d:	83 ec 0c             	sub    $0xc,%esp
80105010:	ff 75 d4             	pushl  -0x2c(%ebp)
80105013:	e8 a8 ce ff ff       	call   80101ec0 <namei>
80105018:	83 c4 10             	add    $0x10,%esp
8010501b:	85 c0                	test   %eax,%eax
8010501d:	89 c3                	mov    %eax,%ebx
8010501f:	0f 84 ea 00 00 00    	je     8010510f <sys_link+0x13f>
  ilock(ip);
80105025:	83 ec 0c             	sub    $0xc,%esp
80105028:	50                   	push   %eax
80105029:	e8 52 c6 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
8010502e:	83 c4 10             	add    $0x10,%esp
80105031:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105036:	0f 84 bb 00 00 00    	je     801050f7 <sys_link+0x127>
  ip->nlink++;
8010503c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105041:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105044:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105047:	53                   	push   %ebx
80105048:	e8 83 c5 ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
8010504d:	89 1c 24             	mov    %ebx,(%esp)
80105050:	e8 0b c7 ff ff       	call   80101760 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105055:	58                   	pop    %eax
80105056:	5a                   	pop    %edx
80105057:	57                   	push   %edi
80105058:	ff 75 d0             	pushl  -0x30(%ebp)
8010505b:	e8 80 ce ff ff       	call   80101ee0 <nameiparent>
80105060:	83 c4 10             	add    $0x10,%esp
80105063:	85 c0                	test   %eax,%eax
80105065:	89 c6                	mov    %eax,%esi
80105067:	74 5b                	je     801050c4 <sys_link+0xf4>
  ilock(dp);
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	50                   	push   %eax
8010506d:	e8 0e c6 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105072:	83 c4 10             	add    $0x10,%esp
80105075:	8b 03                	mov    (%ebx),%eax
80105077:	39 06                	cmp    %eax,(%esi)
80105079:	75 3d                	jne    801050b8 <sys_link+0xe8>
8010507b:	83 ec 04             	sub    $0x4,%esp
8010507e:	ff 73 04             	pushl  0x4(%ebx)
80105081:	57                   	push   %edi
80105082:	56                   	push   %esi
80105083:	e8 78 cd ff ff       	call   80101e00 <dirlink>
80105088:	83 c4 10             	add    $0x10,%esp
8010508b:	85 c0                	test   %eax,%eax
8010508d:	78 29                	js     801050b8 <sys_link+0xe8>
  iunlockput(dp);
8010508f:	83 ec 0c             	sub    $0xc,%esp
80105092:	56                   	push   %esi
80105093:	e8 58 c8 ff ff       	call   801018f0 <iunlockput>
  iput(ip);
80105098:	89 1c 24             	mov    %ebx,(%esp)
8010509b:	e8 10 c7 ff ff       	call   801017b0 <iput>
  end_op();
801050a0:	e8 0b dc ff ff       	call   80102cb0 <end_op>
  return 0;
801050a5:	83 c4 10             	add    $0x10,%esp
801050a8:	31 c0                	xor    %eax,%eax
}
801050aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050ad:	5b                   	pop    %ebx
801050ae:	5e                   	pop    %esi
801050af:	5f                   	pop    %edi
801050b0:	5d                   	pop    %ebp
801050b1:	c3                   	ret    
801050b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801050b8:	83 ec 0c             	sub    $0xc,%esp
801050bb:	56                   	push   %esi
801050bc:	e8 2f c8 ff ff       	call   801018f0 <iunlockput>
    goto bad;
801050c1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801050c4:	83 ec 0c             	sub    $0xc,%esp
801050c7:	53                   	push   %ebx
801050c8:	e8 b3 c5 ff ff       	call   80101680 <ilock>
  ip->nlink--;
801050cd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050d2:	89 1c 24             	mov    %ebx,(%esp)
801050d5:	e8 f6 c4 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
801050da:	89 1c 24             	mov    %ebx,(%esp)
801050dd:	e8 0e c8 ff ff       	call   801018f0 <iunlockput>
  end_op();
801050e2:	e8 c9 db ff ff       	call   80102cb0 <end_op>
  return -1;
801050e7:	83 c4 10             	add    $0x10,%esp
}
801050ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801050ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050f2:	5b                   	pop    %ebx
801050f3:	5e                   	pop    %esi
801050f4:	5f                   	pop    %edi
801050f5:	5d                   	pop    %ebp
801050f6:	c3                   	ret    
    iunlockput(ip);
801050f7:	83 ec 0c             	sub    $0xc,%esp
801050fa:	53                   	push   %ebx
801050fb:	e8 f0 c7 ff ff       	call   801018f0 <iunlockput>
    end_op();
80105100:	e8 ab db ff ff       	call   80102cb0 <end_op>
    return -1;
80105105:	83 c4 10             	add    $0x10,%esp
80105108:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010510d:	eb 9b                	jmp    801050aa <sys_link+0xda>
    end_op();
8010510f:	e8 9c db ff ff       	call   80102cb0 <end_op>
    return -1;
80105114:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105119:	eb 8f                	jmp    801050aa <sys_link+0xda>
8010511b:	90                   	nop
8010511c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105120 <sys_unlink>:
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	57                   	push   %edi
80105124:	56                   	push   %esi
80105125:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105126:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105129:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010512c:	50                   	push   %eax
8010512d:	6a 00                	push   $0x0
8010512f:	e8 cc f9 ff ff       	call   80104b00 <argstr>
80105134:	83 c4 10             	add    $0x10,%esp
80105137:	85 c0                	test   %eax,%eax
80105139:	0f 88 77 01 00 00    	js     801052b6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010513f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105142:	e8 f9 da ff ff       	call   80102c40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105147:	83 ec 08             	sub    $0x8,%esp
8010514a:	53                   	push   %ebx
8010514b:	ff 75 c0             	pushl  -0x40(%ebp)
8010514e:	e8 8d cd ff ff       	call   80101ee0 <nameiparent>
80105153:	83 c4 10             	add    $0x10,%esp
80105156:	85 c0                	test   %eax,%eax
80105158:	89 c6                	mov    %eax,%esi
8010515a:	0f 84 60 01 00 00    	je     801052c0 <sys_unlink+0x1a0>
  ilock(dp);
80105160:	83 ec 0c             	sub    $0xc,%esp
80105163:	50                   	push   %eax
80105164:	e8 17 c5 ff ff       	call   80101680 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105169:	58                   	pop    %eax
8010516a:	5a                   	pop    %edx
8010516b:	68 bc 79 10 80       	push   $0x801079bc
80105170:	53                   	push   %ebx
80105171:	e8 fa c9 ff ff       	call   80101b70 <namecmp>
80105176:	83 c4 10             	add    $0x10,%esp
80105179:	85 c0                	test   %eax,%eax
8010517b:	0f 84 03 01 00 00    	je     80105284 <sys_unlink+0x164>
80105181:	83 ec 08             	sub    $0x8,%esp
80105184:	68 bb 79 10 80       	push   $0x801079bb
80105189:	53                   	push   %ebx
8010518a:	e8 e1 c9 ff ff       	call   80101b70 <namecmp>
8010518f:	83 c4 10             	add    $0x10,%esp
80105192:	85 c0                	test   %eax,%eax
80105194:	0f 84 ea 00 00 00    	je     80105284 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010519a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010519d:	83 ec 04             	sub    $0x4,%esp
801051a0:	50                   	push   %eax
801051a1:	53                   	push   %ebx
801051a2:	56                   	push   %esi
801051a3:	e8 e8 c9 ff ff       	call   80101b90 <dirlookup>
801051a8:	83 c4 10             	add    $0x10,%esp
801051ab:	85 c0                	test   %eax,%eax
801051ad:	89 c3                	mov    %eax,%ebx
801051af:	0f 84 cf 00 00 00    	je     80105284 <sys_unlink+0x164>
  ilock(ip);
801051b5:	83 ec 0c             	sub    $0xc,%esp
801051b8:	50                   	push   %eax
801051b9:	e8 c2 c4 ff ff       	call   80101680 <ilock>
  if(ip->nlink < 1)
801051be:	83 c4 10             	add    $0x10,%esp
801051c1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801051c6:	0f 8e 10 01 00 00    	jle    801052dc <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801051cc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051d1:	74 6d                	je     80105240 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801051d3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801051d6:	83 ec 04             	sub    $0x4,%esp
801051d9:	6a 10                	push   $0x10
801051db:	6a 00                	push   $0x0
801051dd:	50                   	push   %eax
801051de:	e8 8d f5 ff ff       	call   80104770 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051e3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801051e6:	6a 10                	push   $0x10
801051e8:	ff 75 c4             	pushl  -0x3c(%ebp)
801051eb:	50                   	push   %eax
801051ec:	56                   	push   %esi
801051ed:	e8 4e c8 ff ff       	call   80101a40 <writei>
801051f2:	83 c4 20             	add    $0x20,%esp
801051f5:	83 f8 10             	cmp    $0x10,%eax
801051f8:	0f 85 eb 00 00 00    	jne    801052e9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801051fe:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105203:	0f 84 97 00 00 00    	je     801052a0 <sys_unlink+0x180>
  iunlockput(dp);
80105209:	83 ec 0c             	sub    $0xc,%esp
8010520c:	56                   	push   %esi
8010520d:	e8 de c6 ff ff       	call   801018f0 <iunlockput>
  ip->nlink--;
80105212:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105217:	89 1c 24             	mov    %ebx,(%esp)
8010521a:	e8 b1 c3 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
8010521f:	89 1c 24             	mov    %ebx,(%esp)
80105222:	e8 c9 c6 ff ff       	call   801018f0 <iunlockput>
  end_op();
80105227:	e8 84 da ff ff       	call   80102cb0 <end_op>
  return 0;
8010522c:	83 c4 10             	add    $0x10,%esp
8010522f:	31 c0                	xor    %eax,%eax
}
80105231:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105234:	5b                   	pop    %ebx
80105235:	5e                   	pop    %esi
80105236:	5f                   	pop    %edi
80105237:	5d                   	pop    %ebp
80105238:	c3                   	ret    
80105239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105240:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105244:	76 8d                	jbe    801051d3 <sys_unlink+0xb3>
80105246:	bf 20 00 00 00       	mov    $0x20,%edi
8010524b:	eb 0f                	jmp    8010525c <sys_unlink+0x13c>
8010524d:	8d 76 00             	lea    0x0(%esi),%esi
80105250:	83 c7 10             	add    $0x10,%edi
80105253:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105256:	0f 83 77 ff ff ff    	jae    801051d3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010525c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010525f:	6a 10                	push   $0x10
80105261:	57                   	push   %edi
80105262:	50                   	push   %eax
80105263:	53                   	push   %ebx
80105264:	e8 d7 c6 ff ff       	call   80101940 <readi>
80105269:	83 c4 10             	add    $0x10,%esp
8010526c:	83 f8 10             	cmp    $0x10,%eax
8010526f:	75 5e                	jne    801052cf <sys_unlink+0x1af>
    if(de.inum != 0)
80105271:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105276:	74 d8                	je     80105250 <sys_unlink+0x130>
    iunlockput(ip);
80105278:	83 ec 0c             	sub    $0xc,%esp
8010527b:	53                   	push   %ebx
8010527c:	e8 6f c6 ff ff       	call   801018f0 <iunlockput>
    goto bad;
80105281:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105284:	83 ec 0c             	sub    $0xc,%esp
80105287:	56                   	push   %esi
80105288:	e8 63 c6 ff ff       	call   801018f0 <iunlockput>
  end_op();
8010528d:	e8 1e da ff ff       	call   80102cb0 <end_op>
  return -1;
80105292:	83 c4 10             	add    $0x10,%esp
80105295:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010529a:	eb 95                	jmp    80105231 <sys_unlink+0x111>
8010529c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801052a0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801052a5:	83 ec 0c             	sub    $0xc,%esp
801052a8:	56                   	push   %esi
801052a9:	e8 22 c3 ff ff       	call   801015d0 <iupdate>
801052ae:	83 c4 10             	add    $0x10,%esp
801052b1:	e9 53 ff ff ff       	jmp    80105209 <sys_unlink+0xe9>
    return -1;
801052b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052bb:	e9 71 ff ff ff       	jmp    80105231 <sys_unlink+0x111>
    end_op();
801052c0:	e8 eb d9 ff ff       	call   80102cb0 <end_op>
    return -1;
801052c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052ca:	e9 62 ff ff ff       	jmp    80105231 <sys_unlink+0x111>
      panic("isdirempty: readi");
801052cf:	83 ec 0c             	sub    $0xc,%esp
801052d2:	68 e0 79 10 80       	push   $0x801079e0
801052d7:	e8 b4 b0 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801052dc:	83 ec 0c             	sub    $0xc,%esp
801052df:	68 ce 79 10 80       	push   $0x801079ce
801052e4:	e8 a7 b0 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801052e9:	83 ec 0c             	sub    $0xc,%esp
801052ec:	68 f2 79 10 80       	push   $0x801079f2
801052f1:	e8 9a b0 ff ff       	call   80100390 <panic>
801052f6:	8d 76 00             	lea    0x0(%esi),%esi
801052f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105300 <sys_open>:

int
sys_open(void)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	57                   	push   %edi
80105304:	56                   	push   %esi
80105305:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105306:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105309:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010530c:	50                   	push   %eax
8010530d:	6a 00                	push   $0x0
8010530f:	e8 ec f7 ff ff       	call   80104b00 <argstr>
80105314:	83 c4 10             	add    $0x10,%esp
80105317:	85 c0                	test   %eax,%eax
80105319:	0f 88 1d 01 00 00    	js     8010543c <sys_open+0x13c>
8010531f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105322:	83 ec 08             	sub    $0x8,%esp
80105325:	50                   	push   %eax
80105326:	6a 01                	push   $0x1
80105328:	e8 43 f7 ff ff       	call   80104a70 <argint>
8010532d:	83 c4 10             	add    $0x10,%esp
80105330:	85 c0                	test   %eax,%eax
80105332:	0f 88 04 01 00 00    	js     8010543c <sys_open+0x13c>
    return -1;

  begin_op();
80105338:	e8 03 d9 ff ff       	call   80102c40 <begin_op>

  if(omode & O_CREATE){
8010533d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105341:	0f 85 a9 00 00 00    	jne    801053f0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105347:	83 ec 0c             	sub    $0xc,%esp
8010534a:	ff 75 e0             	pushl  -0x20(%ebp)
8010534d:	e8 6e cb ff ff       	call   80101ec0 <namei>
80105352:	83 c4 10             	add    $0x10,%esp
80105355:	85 c0                	test   %eax,%eax
80105357:	89 c6                	mov    %eax,%esi
80105359:	0f 84 b2 00 00 00    	je     80105411 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010535f:	83 ec 0c             	sub    $0xc,%esp
80105362:	50                   	push   %eax
80105363:	e8 18 c3 ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105368:	83 c4 10             	add    $0x10,%esp
8010536b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105370:	0f 84 aa 00 00 00    	je     80105420 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105376:	e8 f5 b9 ff ff       	call   80100d70 <filealloc>
8010537b:	85 c0                	test   %eax,%eax
8010537d:	89 c7                	mov    %eax,%edi
8010537f:	0f 84 a6 00 00 00    	je     8010542b <sys_open+0x12b>
    if(proc->ofile[fd] == 0){
80105385:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  for(fd = 0; fd < NOFILE; fd++){
8010538c:	31 db                	xor    %ebx,%ebx
8010538e:	eb 0c                	jmp    8010539c <sys_open+0x9c>
80105390:	83 c3 01             	add    $0x1,%ebx
80105393:	83 fb 10             	cmp    $0x10,%ebx
80105396:	0f 84 ac 00 00 00    	je     80105448 <sys_open+0x148>
    if(proc->ofile[fd] == 0){
8010539c:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
801053a0:	85 c0                	test   %eax,%eax
801053a2:	75 ec                	jne    80105390 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801053a4:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
801053a7:	89 7c 9a 28          	mov    %edi,0x28(%edx,%ebx,4)
  iunlock(ip);
801053ab:	56                   	push   %esi
801053ac:	e8 af c3 ff ff       	call   80101760 <iunlock>
  end_op();
801053b1:	e8 fa d8 ff ff       	call   80102cb0 <end_op>

  f->type = FD_INODE;
801053b6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801053bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053bf:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801053c2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801053c5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801053cc:	89 d0                	mov    %edx,%eax
801053ce:	f7 d0                	not    %eax
801053d0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053d3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801053d6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053d9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801053dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053e0:	89 d8                	mov    %ebx,%eax
801053e2:	5b                   	pop    %ebx
801053e3:	5e                   	pop    %esi
801053e4:	5f                   	pop    %edi
801053e5:	5d                   	pop    %ebp
801053e6:	c3                   	ret    
801053e7:	89 f6                	mov    %esi,%esi
801053e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801053f0:	83 ec 0c             	sub    $0xc,%esp
801053f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801053f6:	31 c9                	xor    %ecx,%ecx
801053f8:	6a 00                	push   $0x0
801053fa:	ba 02 00 00 00       	mov    $0x2,%edx
801053ff:	e8 ec f7 ff ff       	call   80104bf0 <create>
    if(ip == 0){
80105404:	83 c4 10             	add    $0x10,%esp
80105407:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105409:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010540b:	0f 85 65 ff ff ff    	jne    80105376 <sys_open+0x76>
      end_op();
80105411:	e8 9a d8 ff ff       	call   80102cb0 <end_op>
      return -1;
80105416:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010541b:	eb c0                	jmp    801053dd <sys_open+0xdd>
8010541d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105420:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105423:	85 d2                	test   %edx,%edx
80105425:	0f 84 4b ff ff ff    	je     80105376 <sys_open+0x76>
    iunlockput(ip);
8010542b:	83 ec 0c             	sub    $0xc,%esp
8010542e:	56                   	push   %esi
8010542f:	e8 bc c4 ff ff       	call   801018f0 <iunlockput>
    end_op();
80105434:	e8 77 d8 ff ff       	call   80102cb0 <end_op>
    return -1;
80105439:	83 c4 10             	add    $0x10,%esp
8010543c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105441:	eb 9a                	jmp    801053dd <sys_open+0xdd>
80105443:	90                   	nop
80105444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105448:	83 ec 0c             	sub    $0xc,%esp
8010544b:	57                   	push   %edi
8010544c:	e8 df b9 ff ff       	call   80100e30 <fileclose>
80105451:	83 c4 10             	add    $0x10,%esp
80105454:	eb d5                	jmp    8010542b <sys_open+0x12b>
80105456:	8d 76 00             	lea    0x0(%esi),%esi
80105459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105460 <sys_mkdir>:

int
sys_mkdir(void)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105466:	e8 d5 d7 ff ff       	call   80102c40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010546b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010546e:	83 ec 08             	sub    $0x8,%esp
80105471:	50                   	push   %eax
80105472:	6a 00                	push   $0x0
80105474:	e8 87 f6 ff ff       	call   80104b00 <argstr>
80105479:	83 c4 10             	add    $0x10,%esp
8010547c:	85 c0                	test   %eax,%eax
8010547e:	78 30                	js     801054b0 <sys_mkdir+0x50>
80105480:	83 ec 0c             	sub    $0xc,%esp
80105483:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105486:	31 c9                	xor    %ecx,%ecx
80105488:	6a 00                	push   $0x0
8010548a:	ba 01 00 00 00       	mov    $0x1,%edx
8010548f:	e8 5c f7 ff ff       	call   80104bf0 <create>
80105494:	83 c4 10             	add    $0x10,%esp
80105497:	85 c0                	test   %eax,%eax
80105499:	74 15                	je     801054b0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010549b:	83 ec 0c             	sub    $0xc,%esp
8010549e:	50                   	push   %eax
8010549f:	e8 4c c4 ff ff       	call   801018f0 <iunlockput>
  end_op();
801054a4:	e8 07 d8 ff ff       	call   80102cb0 <end_op>
  return 0;
801054a9:	83 c4 10             	add    $0x10,%esp
801054ac:	31 c0                	xor    %eax,%eax
}
801054ae:	c9                   	leave  
801054af:	c3                   	ret    
    end_op();
801054b0:	e8 fb d7 ff ff       	call   80102cb0 <end_op>
    return -1;
801054b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054ba:	c9                   	leave  
801054bb:	c3                   	ret    
801054bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_mknod>:

int
sys_mknod(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801054c6:	e8 75 d7 ff ff       	call   80102c40 <begin_op>
  if((argstr(0, &path)) < 0 ||
801054cb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801054ce:	83 ec 08             	sub    $0x8,%esp
801054d1:	50                   	push   %eax
801054d2:	6a 00                	push   $0x0
801054d4:	e8 27 f6 ff ff       	call   80104b00 <argstr>
801054d9:	83 c4 10             	add    $0x10,%esp
801054dc:	85 c0                	test   %eax,%eax
801054de:	78 60                	js     80105540 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801054e0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054e3:	83 ec 08             	sub    $0x8,%esp
801054e6:	50                   	push   %eax
801054e7:	6a 01                	push   $0x1
801054e9:	e8 82 f5 ff ff       	call   80104a70 <argint>
  if((argstr(0, &path)) < 0 ||
801054ee:	83 c4 10             	add    $0x10,%esp
801054f1:	85 c0                	test   %eax,%eax
801054f3:	78 4b                	js     80105540 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801054f5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054f8:	83 ec 08             	sub    $0x8,%esp
801054fb:	50                   	push   %eax
801054fc:	6a 02                	push   $0x2
801054fe:	e8 6d f5 ff ff       	call   80104a70 <argint>
     argint(1, &major) < 0 ||
80105503:	83 c4 10             	add    $0x10,%esp
80105506:	85 c0                	test   %eax,%eax
80105508:	78 36                	js     80105540 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010550a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010550e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105511:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105515:	ba 03 00 00 00       	mov    $0x3,%edx
8010551a:	50                   	push   %eax
8010551b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010551e:	e8 cd f6 ff ff       	call   80104bf0 <create>
80105523:	83 c4 10             	add    $0x10,%esp
80105526:	85 c0                	test   %eax,%eax
80105528:	74 16                	je     80105540 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010552a:	83 ec 0c             	sub    $0xc,%esp
8010552d:	50                   	push   %eax
8010552e:	e8 bd c3 ff ff       	call   801018f0 <iunlockput>
  end_op();
80105533:	e8 78 d7 ff ff       	call   80102cb0 <end_op>
  return 0;
80105538:	83 c4 10             	add    $0x10,%esp
8010553b:	31 c0                	xor    %eax,%eax
}
8010553d:	c9                   	leave  
8010553e:	c3                   	ret    
8010553f:	90                   	nop
    end_op();
80105540:	e8 6b d7 ff ff       	call   80102cb0 <end_op>
    return -1;
80105545:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010554a:	c9                   	leave  
8010554b:	c3                   	ret    
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <sys_chdir>:

int
sys_chdir(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	53                   	push   %ebx
80105554:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105557:	e8 e4 d6 ff ff       	call   80102c40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010555c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010555f:	83 ec 08             	sub    $0x8,%esp
80105562:	50                   	push   %eax
80105563:	6a 00                	push   $0x0
80105565:	e8 96 f5 ff ff       	call   80104b00 <argstr>
8010556a:	83 c4 10             	add    $0x10,%esp
8010556d:	85 c0                	test   %eax,%eax
8010556f:	78 7f                	js     801055f0 <sys_chdir+0xa0>
80105571:	83 ec 0c             	sub    $0xc,%esp
80105574:	ff 75 f4             	pushl  -0xc(%ebp)
80105577:	e8 44 c9 ff ff       	call   80101ec0 <namei>
8010557c:	83 c4 10             	add    $0x10,%esp
8010557f:	85 c0                	test   %eax,%eax
80105581:	89 c3                	mov    %eax,%ebx
80105583:	74 6b                	je     801055f0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105585:	83 ec 0c             	sub    $0xc,%esp
80105588:	50                   	push   %eax
80105589:	e8 f2 c0 ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
8010558e:	83 c4 10             	add    $0x10,%esp
80105591:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105596:	75 38                	jne    801055d0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105598:	83 ec 0c             	sub    $0xc,%esp
8010559b:	53                   	push   %ebx
8010559c:	e8 bf c1 ff ff       	call   80101760 <iunlock>
  iput(proc->cwd);
801055a1:	58                   	pop    %eax
801055a2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055a8:	ff 70 68             	pushl  0x68(%eax)
801055ab:	e8 00 c2 ff ff       	call   801017b0 <iput>
  end_op();
801055b0:	e8 fb d6 ff ff       	call   80102cb0 <end_op>
  proc->cwd = ip;
801055b5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
801055bb:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
801055be:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
801055c1:	31 c0                	xor    %eax,%eax
}
801055c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055c6:	c9                   	leave  
801055c7:	c3                   	ret    
801055c8:	90                   	nop
801055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
801055d0:	83 ec 0c             	sub    $0xc,%esp
801055d3:	53                   	push   %ebx
801055d4:	e8 17 c3 ff ff       	call   801018f0 <iunlockput>
    end_op();
801055d9:	e8 d2 d6 ff ff       	call   80102cb0 <end_op>
    return -1;
801055de:	83 c4 10             	add    $0x10,%esp
801055e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055e6:	eb db                	jmp    801055c3 <sys_chdir+0x73>
801055e8:	90                   	nop
801055e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801055f0:	e8 bb d6 ff ff       	call   80102cb0 <end_op>
    return -1;
801055f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055fa:	eb c7                	jmp    801055c3 <sys_chdir+0x73>
801055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105600 <sys_exec>:

int
sys_exec(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	57                   	push   %edi
80105604:	56                   	push   %esi
80105605:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105606:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010560c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105612:	50                   	push   %eax
80105613:	6a 00                	push   $0x0
80105615:	e8 e6 f4 ff ff       	call   80104b00 <argstr>
8010561a:	83 c4 10             	add    $0x10,%esp
8010561d:	85 c0                	test   %eax,%eax
8010561f:	0f 88 87 00 00 00    	js     801056ac <sys_exec+0xac>
80105625:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010562b:	83 ec 08             	sub    $0x8,%esp
8010562e:	50                   	push   %eax
8010562f:	6a 01                	push   $0x1
80105631:	e8 3a f4 ff ff       	call   80104a70 <argint>
80105636:	83 c4 10             	add    $0x10,%esp
80105639:	85 c0                	test   %eax,%eax
8010563b:	78 6f                	js     801056ac <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010563d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105643:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105646:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105648:	68 80 00 00 00       	push   $0x80
8010564d:	6a 00                	push   $0x0
8010564f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105655:	50                   	push   %eax
80105656:	e8 15 f1 ff ff       	call   80104770 <memset>
8010565b:	83 c4 10             	add    $0x10,%esp
8010565e:	eb 2c                	jmp    8010568c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105660:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105666:	85 c0                	test   %eax,%eax
80105668:	74 56                	je     801056c0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010566a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105670:	83 ec 08             	sub    $0x8,%esp
80105673:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105676:	52                   	push   %edx
80105677:	50                   	push   %eax
80105678:	e8 93 f3 ff ff       	call   80104a10 <fetchstr>
8010567d:	83 c4 10             	add    $0x10,%esp
80105680:	85 c0                	test   %eax,%eax
80105682:	78 28                	js     801056ac <sys_exec+0xac>
  for(i=0;; i++){
80105684:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105687:	83 fb 20             	cmp    $0x20,%ebx
8010568a:	74 20                	je     801056ac <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010568c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105692:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105699:	83 ec 08             	sub    $0x8,%esp
8010569c:	57                   	push   %edi
8010569d:	01 f0                	add    %esi,%eax
8010569f:	50                   	push   %eax
801056a0:	e8 3b f3 ff ff       	call   801049e0 <fetchint>
801056a5:	83 c4 10             	add    $0x10,%esp
801056a8:	85 c0                	test   %eax,%eax
801056aa:	79 b4                	jns    80105660 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801056ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801056af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056b4:	5b                   	pop    %ebx
801056b5:	5e                   	pop    %esi
801056b6:	5f                   	pop    %edi
801056b7:	5d                   	pop    %ebp
801056b8:	c3                   	ret    
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801056c0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801056c6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801056c9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801056d0:	00 00 00 00 
  return exec(path, argv);
801056d4:	50                   	push   %eax
801056d5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801056db:	e8 30 b3 ff ff       	call   80100a10 <exec>
801056e0:	83 c4 10             	add    $0x10,%esp
}
801056e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056e6:	5b                   	pop    %ebx
801056e7:	5e                   	pop    %esi
801056e8:	5f                   	pop    %edi
801056e9:	5d                   	pop    %ebp
801056ea:	c3                   	ret    
801056eb:	90                   	nop
801056ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056f0 <sys_pipe>:

int
sys_pipe(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	57                   	push   %edi
801056f4:	56                   	push   %esi
801056f5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056f6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801056f9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056fc:	6a 08                	push   $0x8
801056fe:	50                   	push   %eax
801056ff:	6a 00                	push   $0x0
80105701:	e8 aa f3 ff ff       	call   80104ab0 <argptr>
80105706:	83 c4 10             	add    $0x10,%esp
80105709:	85 c0                	test   %eax,%eax
8010570b:	0f 88 a4 00 00 00    	js     801057b5 <sys_pipe+0xc5>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105711:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105714:	83 ec 08             	sub    $0x8,%esp
80105717:	50                   	push   %eax
80105718:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010571b:	50                   	push   %eax
8010571c:	e8 bf dc ff ff       	call   801033e0 <pipealloc>
80105721:	83 c4 10             	add    $0x10,%esp
80105724:	85 c0                	test   %eax,%eax
80105726:	0f 88 89 00 00 00    	js     801057b5 <sys_pipe+0xc5>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010572c:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    if(proc->ofile[fd] == 0){
8010572f:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
80105736:	31 c0                	xor    %eax,%eax
80105738:	eb 0e                	jmp    80105748 <sys_pipe+0x58>
8010573a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105740:	83 c0 01             	add    $0x1,%eax
80105743:	83 f8 10             	cmp    $0x10,%eax
80105746:	74 58                	je     801057a0 <sys_pipe+0xb0>
    if(proc->ofile[fd] == 0){
80105748:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
8010574c:	85 d2                	test   %edx,%edx
8010574e:	75 f0                	jne    80105740 <sys_pipe+0x50>
80105750:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105753:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105756:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
80105758:	89 5e 28             	mov    %ebx,0x28(%esi)
8010575b:	eb 0b                	jmp    80105768 <sys_pipe+0x78>
8010575d:	8d 76 00             	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105760:	83 c2 01             	add    $0x1,%edx
80105763:	83 fa 10             	cmp    $0x10,%edx
80105766:	74 28                	je     80105790 <sys_pipe+0xa0>
    if(proc->ofile[fd] == 0){
80105768:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
8010576d:	75 f1                	jne    80105760 <sys_pipe+0x70>
      proc->ofile[fd] = f;
8010576f:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105773:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105776:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105778:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010577b:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010577e:	31 c0                	xor    %eax,%eax
}
80105780:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105783:	5b                   	pop    %ebx
80105784:	5e                   	pop    %esi
80105785:	5f                   	pop    %edi
80105786:	5d                   	pop    %ebp
80105787:	c3                   	ret    
80105788:	90                   	nop
80105789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd0] = 0;
80105790:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
80105797:	89 f6                	mov    %esi,%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fileclose(rf);
801057a0:	83 ec 0c             	sub    $0xc,%esp
801057a3:	53                   	push   %ebx
801057a4:	e8 87 b6 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
801057a9:	58                   	pop    %eax
801057aa:	ff 75 e4             	pushl  -0x1c(%ebp)
801057ad:	e8 7e b6 ff ff       	call   80100e30 <fileclose>
    return -1;
801057b2:	83 c4 10             	add    $0x10,%esp
801057b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ba:	eb c4                	jmp    80105780 <sys_pipe+0x90>
801057bc:	66 90                	xchg   %ax,%ax
801057be:	66 90                	xchg   %ax,%ax

801057c0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801057c3:	5d                   	pop    %ebp
  return fork();
801057c4:	e9 e7 e2 ff ff       	jmp    80103ab0 <fork>
801057c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801057d0 <sys_exit>:

int
sys_exit(void)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	83 ec 08             	sub    $0x8,%esp
  exit();
801057d6:	e8 c5 e5 ff ff       	call   80103da0 <exit>
  return 0;  // not reached
}
801057db:	31 c0                	xor    %eax,%eax
801057dd:	c9                   	leave  
801057de:	c3                   	ret    
801057df:	90                   	nop

801057e0 <sys_wait>:

int
sys_wait(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801057e3:	5d                   	pop    %ebp
  return wait();
801057e4:	e9 07 e8 ff ff       	jmp    80103ff0 <wait>
801057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801057f0 <sys_kill>:

int
sys_kill(void)
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801057f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057f9:	50                   	push   %eax
801057fa:	6a 00                	push   $0x0
801057fc:	e8 6f f2 ff ff       	call   80104a70 <argint>
80105801:	83 c4 10             	add    $0x10,%esp
80105804:	85 c0                	test   %eax,%eax
80105806:	78 18                	js     80105820 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105808:	83 ec 0c             	sub    $0xc,%esp
8010580b:	ff 75 f4             	pushl  -0xc(%ebp)
8010580e:	e8 2d e9 ff ff       	call   80104140 <kill>
80105813:	83 c4 10             	add    $0x10,%esp
}
80105816:	c9                   	leave  
80105817:	c3                   	ret    
80105818:	90                   	nop
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105825:	c9                   	leave  
80105826:	c3                   	ret    
80105827:	89 f6                	mov    %esi,%esi
80105829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105830 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105830:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80105836:	55                   	push   %ebp
80105837:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105839:	8b 40 10             	mov    0x10(%eax),%eax
}
8010583c:	5d                   	pop    %ebp
8010583d:	c3                   	ret    
8010583e:	66 90                	xchg   %ax,%ax

80105840 <sys_sbrk>:

int
sys_sbrk(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105844:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105847:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010584a:	50                   	push   %eax
8010584b:	6a 00                	push   $0x0
8010584d:	e8 1e f2 ff ff       	call   80104a70 <argint>
80105852:	83 c4 10             	add    $0x10,%esp
80105855:	85 c0                	test   %eax,%eax
80105857:	78 27                	js     80105880 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105859:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
8010585f:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
80105862:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105864:	ff 75 f4             	pushl  -0xc(%ebp)
80105867:	e8 c4 e1 ff ff       	call   80103a30 <growproc>
8010586c:	83 c4 10             	add    $0x10,%esp
8010586f:	85 c0                	test   %eax,%eax
80105871:	78 0d                	js     80105880 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105873:	89 d8                	mov    %ebx,%eax
80105875:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105878:	c9                   	leave  
80105879:	c3                   	ret    
8010587a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105880:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105885:	eb ec                	jmp    80105873 <sys_sbrk+0x33>
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <sys_sleep>:

int
sys_sleep(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105894:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105897:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010589a:	50                   	push   %eax
8010589b:	6a 00                	push   $0x0
8010589d:	e8 ce f1 ff ff       	call   80104a70 <argint>
801058a2:	83 c4 10             	add    $0x10,%esp
801058a5:	85 c0                	test   %eax,%eax
801058a7:	0f 88 8a 00 00 00    	js     80105937 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801058ad:	83 ec 0c             	sub    $0xc,%esp
801058b0:	68 e0 4e 11 80       	push   $0x80114ee0
801058b5:	e8 a6 ec ff ff       	call   80104560 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801058ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058bd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801058c0:	8b 1d 20 57 11 80    	mov    0x80115720,%ebx
  while(ticks - ticks0 < n){
801058c6:	85 d2                	test   %edx,%edx
801058c8:	75 27                	jne    801058f1 <sys_sleep+0x61>
801058ca:	eb 54                	jmp    80105920 <sys_sleep+0x90>
801058cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801058d0:	83 ec 08             	sub    $0x8,%esp
801058d3:	68 e0 4e 11 80       	push   $0x80114ee0
801058d8:	68 20 57 11 80       	push   $0x80115720
801058dd:	e8 4e e6 ff ff       	call   80103f30 <sleep>
  while(ticks - ticks0 < n){
801058e2:	a1 20 57 11 80       	mov    0x80115720,%eax
801058e7:	83 c4 10             	add    $0x10,%esp
801058ea:	29 d8                	sub    %ebx,%eax
801058ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801058ef:	73 2f                	jae    80105920 <sys_sleep+0x90>
    if(proc->killed){
801058f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058f7:	8b 40 24             	mov    0x24(%eax),%eax
801058fa:	85 c0                	test   %eax,%eax
801058fc:	74 d2                	je     801058d0 <sys_sleep+0x40>
      release(&tickslock);
801058fe:	83 ec 0c             	sub    $0xc,%esp
80105901:	68 e0 4e 11 80       	push   $0x80114ee0
80105906:	e8 15 ee ff ff       	call   80104720 <release>
      return -1;
8010590b:	83 c4 10             	add    $0x10,%esp
8010590e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105913:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105916:	c9                   	leave  
80105917:	c3                   	ret    
80105918:	90                   	nop
80105919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80105920:	83 ec 0c             	sub    $0xc,%esp
80105923:	68 e0 4e 11 80       	push   $0x80114ee0
80105928:	e8 f3 ed ff ff       	call   80104720 <release>
  return 0;
8010592d:	83 c4 10             	add    $0x10,%esp
80105930:	31 c0                	xor    %eax,%eax
}
80105932:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105935:	c9                   	leave  
80105936:	c3                   	ret    
    return -1;
80105937:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010593c:	eb f4                	jmp    80105932 <sys_sleep+0xa2>
8010593e:	66 90                	xchg   %ax,%ax

80105940 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	53                   	push   %ebx
80105944:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105947:	68 e0 4e 11 80       	push   $0x80114ee0
8010594c:	e8 0f ec ff ff       	call   80104560 <acquire>
  xticks = ticks;
80105951:	8b 1d 20 57 11 80    	mov    0x80115720,%ebx
  release(&tickslock);
80105957:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
8010595e:	e8 bd ed ff ff       	call   80104720 <release>
  return xticks;
}
80105963:	89 d8                	mov    %ebx,%eax
80105965:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105968:	c9                   	leave  
80105969:	c3                   	ret    
8010596a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105970 <sys_getNumProc>:
//My Commands starts here :)
int sys_getNumProc(void){
80105970:	55                   	push   %ebp
80105971:	89 e5                	mov    %esp,%ebp
	return getNumProc();
}
80105973:	5d                   	pop    %ebp
	return getNumProc();
80105974:	e9 17 e9 ff ff       	jmp    80104290 <getNumProc>
80105979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105980 <sys_chpr>:

//For Priority Inversion
int sys_chpr (void){
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;
  if(argint(0, &pid) < 0)
80105986:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105989:	50                   	push   %eax
8010598a:	6a 00                	push   $0x0
8010598c:	e8 df f0 ff ff       	call   80104a70 <argint>
80105991:	83 c4 10             	add    $0x10,%esp
80105994:	85 c0                	test   %eax,%eax
80105996:	78 28                	js     801059c0 <sys_chpr+0x40>
    return -1;
  if(argint(1, &pr) < 0)
80105998:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010599b:	83 ec 08             	sub    $0x8,%esp
8010599e:	50                   	push   %eax
8010599f:	6a 01                	push   $0x1
801059a1:	e8 ca f0 ff ff       	call   80104a70 <argint>
801059a6:	83 c4 10             	add    $0x10,%esp
801059a9:	85 c0                	test   %eax,%eax
801059ab:	78 13                	js     801059c0 <sys_chpr+0x40>
    return -1;
  return chpr ( pid, pr );
801059ad:	83 ec 08             	sub    $0x8,%esp
801059b0:	ff 75 f4             	pushl  -0xc(%ebp)
801059b3:	ff 75 f0             	pushl  -0x10(%ebp)
801059b6:	e8 25 ea ff ff       	call   801043e0 <chpr>
801059bb:	83 c4 10             	add    $0x10,%esp
}
801059be:	c9                   	leave  
801059bf:	c3                   	ret    
    return -1;
801059c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059c5:	c9                   	leave  
801059c6:	c3                   	ret    
801059c7:	66 90                	xchg   %ax,%ax
801059c9:	66 90                	xchg   %ax,%ax
801059cb:	66 90                	xchg   %ax,%ax
801059cd:	66 90                	xchg   %ax,%ax
801059cf:	90                   	nop

801059d0 <timerinit>:
801059d0:	55                   	push   %ebp
801059d1:	b8 34 00 00 00       	mov    $0x34,%eax
801059d6:	ba 43 00 00 00       	mov    $0x43,%edx
801059db:	89 e5                	mov    %esp,%ebp
801059dd:	83 ec 14             	sub    $0x14,%esp
801059e0:	ee                   	out    %al,(%dx)
801059e1:	ba 40 00 00 00       	mov    $0x40,%edx
801059e6:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
801059eb:	ee                   	out    %al,(%dx)
801059ec:	b8 2e 00 00 00       	mov    $0x2e,%eax
801059f1:	ee                   	out    %al,(%dx)
801059f2:	6a 00                	push   $0x0
801059f4:	e8 17 d9 ff ff       	call   80103310 <picenable>
801059f9:	83 c4 10             	add    $0x10,%esp
801059fc:	c9                   	leave  
801059fd:	c3                   	ret    

801059fe <alltraps>:
801059fe:	1e                   	push   %ds
801059ff:	06                   	push   %es
80105a00:	0f a0                	push   %fs
80105a02:	0f a8                	push   %gs
80105a04:	60                   	pusha  
80105a05:	66 b8 10 00          	mov    $0x10,%ax
80105a09:	8e d8                	mov    %eax,%ds
80105a0b:	8e c0                	mov    %eax,%es
80105a0d:	66 b8 18 00          	mov    $0x18,%ax
80105a11:	8e e0                	mov    %eax,%fs
80105a13:	8e e8                	mov    %eax,%gs
80105a15:	54                   	push   %esp
80105a16:	e8 c5 00 00 00       	call   80105ae0 <trap>
80105a1b:	83 c4 04             	add    $0x4,%esp

80105a1e <trapret>:
80105a1e:	61                   	popa   
80105a1f:	0f a9                	pop    %gs
80105a21:	0f a1                	pop    %fs
80105a23:	07                   	pop    %es
80105a24:	1f                   	pop    %ds
80105a25:	83 c4 08             	add    $0x8,%esp
80105a28:	cf                   	iret   
80105a29:	66 90                	xchg   %ax,%ax
80105a2b:	66 90                	xchg   %ax,%ax
80105a2d:	66 90                	xchg   %ax,%ax
80105a2f:	90                   	nop

80105a30 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a30:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105a31:	31 c0                	xor    %eax,%eax
{
80105a33:	89 e5                	mov    %esp,%ebp
80105a35:	83 ec 08             	sub    $0x8,%esp
80105a38:	90                   	nop
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a40:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105a47:	c7 04 c5 22 4f 11 80 	movl   $0x8e000008,-0x7feeb0de(,%eax,8)
80105a4e:	08 00 00 8e 
80105a52:	66 89 14 c5 20 4f 11 	mov    %dx,-0x7feeb0e0(,%eax,8)
80105a59:	80 
80105a5a:	c1 ea 10             	shr    $0x10,%edx
80105a5d:	66 89 14 c5 26 4f 11 	mov    %dx,-0x7feeb0da(,%eax,8)
80105a64:	80 
  for(i = 0; i < 256; i++)
80105a65:	83 c0 01             	add    $0x1,%eax
80105a68:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a6d:	75 d1                	jne    80105a40 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a6f:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105a74:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a77:	c7 05 22 51 11 80 08 	movl   $0xef000008,0x80115122
80105a7e:	00 00 ef 
  initlock(&tickslock, "time");
80105a81:	68 01 7a 10 80       	push   $0x80107a01
80105a86:	68 e0 4e 11 80       	push   $0x80114ee0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a8b:	66 a3 20 51 11 80    	mov    %ax,0x80115120
80105a91:	c1 e8 10             	shr    $0x10,%eax
80105a94:	66 a3 26 51 11 80    	mov    %ax,0x80115126
  initlock(&tickslock, "time");
80105a9a:	e8 a1 ea ff ff       	call   80104540 <initlock>
}
80105a9f:	83 c4 10             	add    $0x10,%esp
80105aa2:	c9                   	leave  
80105aa3:	c3                   	ret    
80105aa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105aaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105ab0 <idtinit>:

void
idtinit(void)
{
80105ab0:	55                   	push   %ebp
  pd[0] = size-1;
80105ab1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105ab6:	89 e5                	mov    %esp,%ebp
80105ab8:	83 ec 10             	sub    $0x10,%esp
80105abb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105abf:	b8 20 4f 11 80       	mov    $0x80114f20,%eax
80105ac4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105ac8:	c1 e8 10             	shr    $0x10,%eax
80105acb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105acf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ad2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ad5:	c9                   	leave  
80105ad6:	c3                   	ret    
80105ad7:	89 f6                	mov    %esi,%esi
80105ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ae0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	57                   	push   %edi
80105ae4:	56                   	push   %esi
80105ae5:	53                   	push   %ebx
80105ae6:	83 ec 0c             	sub    $0xc,%esp
80105ae9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105aec:	8b 43 30             	mov    0x30(%ebx),%eax
80105aef:	83 f8 40             	cmp    $0x40,%eax
80105af2:	74 6c                	je     80105b60 <trap+0x80>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105af4:	83 e8 20             	sub    $0x20,%eax
80105af7:	83 f8 1f             	cmp    $0x1f,%eax
80105afa:	0f 87 98 00 00 00    	ja     80105b98 <trap+0xb8>
80105b00:	ff 24 85 a8 7a 10 80 	jmp    *-0x7fef8558(,%eax,4)
80105b07:	89 f6                	mov    %esi,%esi
80105b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105b10:	e8 2b cc ff ff       	call   80102740 <cpunum>
80105b15:	85 c0                	test   %eax,%eax
80105b17:	0f 84 a3 01 00 00    	je     80105cc0 <trap+0x1e0>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105b1d:	e8 ce cc ff ff       	call   801027f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b22:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b28:	85 c0                	test   %eax,%eax
80105b2a:	74 29                	je     80105b55 <trap+0x75>
80105b2c:	8b 50 24             	mov    0x24(%eax),%edx
80105b2f:	85 d2                	test   %edx,%edx
80105b31:	0f 85 b6 00 00 00    	jne    80105bed <trap+0x10d>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105b37:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b3b:	0f 84 3f 01 00 00    	je     80105c80 <trap+0x1a0>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b41:	8b 40 24             	mov    0x24(%eax),%eax
80105b44:	85 c0                	test   %eax,%eax
80105b46:	74 0d                	je     80105b55 <trap+0x75>
80105b48:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105b4c:	83 e0 03             	and    $0x3,%eax
80105b4f:	66 83 f8 03          	cmp    $0x3,%ax
80105b53:	74 31                	je     80105b86 <trap+0xa6>
    exit();
}
80105b55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b58:	5b                   	pop    %ebx
80105b59:	5e                   	pop    %esi
80105b5a:	5f                   	pop    %edi
80105b5b:	5d                   	pop    %ebp
80105b5c:	c3                   	ret    
80105b5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(proc->killed)
80105b60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b66:	8b 70 24             	mov    0x24(%eax),%esi
80105b69:	85 f6                	test   %esi,%esi
80105b6b:	0f 85 37 01 00 00    	jne    80105ca8 <trap+0x1c8>
    proc->tf = tf;
80105b71:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105b74:	e8 07 f0 ff ff       	call   80104b80 <syscall>
    if(proc->killed)
80105b79:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b7f:	8b 58 24             	mov    0x24(%eax),%ebx
80105b82:	85 db                	test   %ebx,%ebx
80105b84:	74 cf                	je     80105b55 <trap+0x75>
}
80105b86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b89:	5b                   	pop    %ebx
80105b8a:	5e                   	pop    %esi
80105b8b:	5f                   	pop    %edi
80105b8c:	5d                   	pop    %ebp
      exit();
80105b8d:	e9 0e e2 ff ff       	jmp    80103da0 <exit>
80105b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc == 0 || (tf->cs&3) == 0){
80105b98:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105b9f:	8b 73 38             	mov    0x38(%ebx),%esi
80105ba2:	85 c9                	test   %ecx,%ecx
80105ba4:	0f 84 4a 01 00 00    	je     80105cf4 <trap+0x214>
80105baa:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105bae:	0f 84 40 01 00 00    	je     80105cf4 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105bb4:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bb7:	e8 84 cb ff ff       	call   80102740 <cpunum>
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bbc:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bc3:	57                   	push   %edi
80105bc4:	56                   	push   %esi
80105bc5:	50                   	push   %eax
80105bc6:	ff 73 34             	pushl  0x34(%ebx)
80105bc9:	ff 73 30             	pushl  0x30(%ebx)
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bcc:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bcf:	50                   	push   %eax
80105bd0:	ff 72 10             	pushl  0x10(%edx)
80105bd3:	68 64 7a 10 80       	push   $0x80107a64
80105bd8:	e8 83 aa ff ff       	call   80100660 <cprintf>
    proc->killed = 1;
80105bdd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105be3:	83 c4 20             	add    $0x20,%esp
80105be6:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105bed:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105bf1:	83 e2 03             	and    $0x3,%edx
80105bf4:	66 83 fa 03          	cmp    $0x3,%dx
80105bf8:	0f 85 39 ff ff ff    	jne    80105b37 <trap+0x57>
    exit();
80105bfe:	e8 9d e1 ff ff       	call   80103da0 <exit>
80105c03:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c09:	85 c0                	test   %eax,%eax
80105c0b:	0f 85 26 ff ff ff    	jne    80105b37 <trap+0x57>
80105c11:	e9 3f ff ff ff       	jmp    80105b55 <trap+0x75>
80105c16:	8d 76 00             	lea    0x0(%esi),%esi
80105c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80105c20:	e8 fb c9 ff ff       	call   80102620 <kbdintr>
    lapiceoi();
80105c25:	e8 c6 cb ff ff       	call   801027f0 <lapiceoi>
    break;
80105c2a:	e9 f3 fe ff ff       	jmp    80105b22 <trap+0x42>
80105c2f:	90                   	nop
    uartintr();
80105c30:	e8 5b 02 00 00       	call   80105e90 <uartintr>
80105c35:	e9 e3 fe ff ff       	jmp    80105b1d <trap+0x3d>
80105c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105c40:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105c44:	8b 7b 38             	mov    0x38(%ebx),%edi
80105c47:	e8 f4 ca ff ff       	call   80102740 <cpunum>
80105c4c:	57                   	push   %edi
80105c4d:	56                   	push   %esi
80105c4e:	50                   	push   %eax
80105c4f:	68 0c 7a 10 80       	push   $0x80107a0c
80105c54:	e8 07 aa ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105c59:	e8 92 cb ff ff       	call   801027f0 <lapiceoi>
    break;
80105c5e:	83 c4 10             	add    $0x10,%esp
80105c61:	e9 bc fe ff ff       	jmp    80105b22 <trap+0x42>
80105c66:	8d 76 00             	lea    0x0(%esi),%esi
80105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80105c70:	e8 fb c3 ff ff       	call   80102070 <ideintr>
    lapiceoi();
80105c75:	e8 76 cb ff ff       	call   801027f0 <lapiceoi>
    break;
80105c7a:	e9 a3 fe ff ff       	jmp    80105b22 <trap+0x42>
80105c7f:	90                   	nop
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c80:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105c84:	0f 85 b7 fe ff ff    	jne    80105b41 <trap+0x61>
    yield();
80105c8a:	e8 61 e2 ff ff       	call   80103ef0 <yield>
80105c8f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c95:	85 c0                	test   %eax,%eax
80105c97:	0f 85 a4 fe ff ff    	jne    80105b41 <trap+0x61>
80105c9d:	e9 b3 fe ff ff       	jmp    80105b55 <trap+0x75>
80105ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105ca8:	e8 f3 e0 ff ff       	call   80103da0 <exit>
80105cad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105cb3:	e9 b9 fe ff ff       	jmp    80105b71 <trap+0x91>
80105cb8:	90                   	nop
80105cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80105cc0:	83 ec 0c             	sub    $0xc,%esp
80105cc3:	68 e0 4e 11 80       	push   $0x80114ee0
80105cc8:	e8 93 e8 ff ff       	call   80104560 <acquire>
      wakeup(&ticks);
80105ccd:	c7 04 24 20 57 11 80 	movl   $0x80115720,(%esp)
      ticks++;
80105cd4:	83 05 20 57 11 80 01 	addl   $0x1,0x80115720
      wakeup(&ticks);
80105cdb:	e8 00 e4 ff ff       	call   801040e0 <wakeup>
      release(&tickslock);
80105ce0:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105ce7:	e8 34 ea ff ff       	call   80104720 <release>
80105cec:	83 c4 10             	add    $0x10,%esp
80105cef:	e9 29 fe ff ff       	jmp    80105b1d <trap+0x3d>
80105cf4:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105cf7:	e8 44 ca ff ff       	call   80102740 <cpunum>
80105cfc:	83 ec 0c             	sub    $0xc,%esp
80105cff:	57                   	push   %edi
80105d00:	56                   	push   %esi
80105d01:	50                   	push   %eax
80105d02:	ff 73 30             	pushl  0x30(%ebx)
80105d05:	68 30 7a 10 80       	push   $0x80107a30
80105d0a:	e8 51 a9 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105d0f:	83 c4 14             	add    $0x14,%esp
80105d12:	68 06 7a 10 80       	push   $0x80107a06
80105d17:	e8 74 a6 ff ff       	call   80100390 <panic>
80105d1c:	66 90                	xchg   %ax,%ax
80105d1e:	66 90                	xchg   %ax,%ax

80105d20 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d20:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
{
80105d25:	55                   	push   %ebp
80105d26:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105d28:	85 c0                	test   %eax,%eax
80105d2a:	74 1c                	je     80105d48 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d2c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d31:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d32:	a8 01                	test   $0x1,%al
80105d34:	74 12                	je     80105d48 <uartgetc+0x28>
80105d36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d3b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d3c:	0f b6 c0             	movzbl %al,%eax
}
80105d3f:	5d                   	pop    %ebp
80105d40:	c3                   	ret    
80105d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d4d:	5d                   	pop    %ebp
80105d4e:	c3                   	ret    
80105d4f:	90                   	nop

80105d50 <uartputc.part.0>:
uartputc(int c)
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	57                   	push   %edi
80105d54:	56                   	push   %esi
80105d55:	53                   	push   %ebx
80105d56:	89 c7                	mov    %eax,%edi
80105d58:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d5d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d62:	83 ec 0c             	sub    $0xc,%esp
80105d65:	eb 1b                	jmp    80105d82 <uartputc.part.0+0x32>
80105d67:	89 f6                	mov    %esi,%esi
80105d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105d70:	83 ec 0c             	sub    $0xc,%esp
80105d73:	6a 0a                	push   $0xa
80105d75:	e8 96 ca ff ff       	call   80102810 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d7a:	83 c4 10             	add    $0x10,%esp
80105d7d:	83 eb 01             	sub    $0x1,%ebx
80105d80:	74 07                	je     80105d89 <uartputc.part.0+0x39>
80105d82:	89 f2                	mov    %esi,%edx
80105d84:	ec                   	in     (%dx),%al
80105d85:	a8 20                	test   $0x20,%al
80105d87:	74 e7                	je     80105d70 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d89:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d8e:	89 f8                	mov    %edi,%eax
80105d90:	ee                   	out    %al,(%dx)
}
80105d91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d94:	5b                   	pop    %ebx
80105d95:	5e                   	pop    %esi
80105d96:	5f                   	pop    %edi
80105d97:	5d                   	pop    %ebp
80105d98:	c3                   	ret    
80105d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105da0 <uartinit>:
{
80105da0:	55                   	push   %ebp
80105da1:	31 c9                	xor    %ecx,%ecx
80105da3:	89 c8                	mov    %ecx,%eax
80105da5:	89 e5                	mov    %esp,%ebp
80105da7:	57                   	push   %edi
80105da8:	56                   	push   %esi
80105da9:	53                   	push   %ebx
80105daa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105daf:	89 da                	mov    %ebx,%edx
80105db1:	83 ec 0c             	sub    $0xc,%esp
80105db4:	ee                   	out    %al,(%dx)
80105db5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105dba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105dbf:	89 fa                	mov    %edi,%edx
80105dc1:	ee                   	out    %al,(%dx)
80105dc2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105dc7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dcc:	ee                   	out    %al,(%dx)
80105dcd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105dd2:	89 c8                	mov    %ecx,%eax
80105dd4:	89 f2                	mov    %esi,%edx
80105dd6:	ee                   	out    %al,(%dx)
80105dd7:	b8 03 00 00 00       	mov    $0x3,%eax
80105ddc:	89 fa                	mov    %edi,%edx
80105dde:	ee                   	out    %al,(%dx)
80105ddf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105de4:	89 c8                	mov    %ecx,%eax
80105de6:	ee                   	out    %al,(%dx)
80105de7:	b8 01 00 00 00       	mov    $0x1,%eax
80105dec:	89 f2                	mov    %esi,%edx
80105dee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105def:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105df4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105df5:	3c ff                	cmp    $0xff,%al
80105df7:	74 5a                	je     80105e53 <uartinit+0xb3>
  uart = 1;
80105df9:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105e00:	00 00 00 
80105e03:	89 da                	mov    %ebx,%edx
80105e05:	ec                   	in     (%dx),%al
80105e06:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e0b:	ec                   	in     (%dx),%al
  picenable(IRQ_COM1);
80105e0c:	83 ec 0c             	sub    $0xc,%esp
80105e0f:	6a 04                	push   $0x4
80105e11:	e8 fa d4 ff ff       	call   80103310 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105e16:	59                   	pop    %ecx
80105e17:	5b                   	pop    %ebx
80105e18:	6a 00                	push   $0x0
80105e1a:	6a 04                	push   $0x4
  for(p="xv6...\n"; *p; p++)
80105e1c:	bb 28 7b 10 80       	mov    $0x80107b28,%ebx
  ioapicenable(IRQ_COM1, 0);
80105e21:	e8 ba c4 ff ff       	call   801022e0 <ioapicenable>
80105e26:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105e29:	b8 78 00 00 00       	mov    $0x78,%eax
80105e2e:	eb 0a                	jmp    80105e3a <uartinit+0x9a>
80105e30:	83 c3 01             	add    $0x1,%ebx
80105e33:	0f be 03             	movsbl (%ebx),%eax
80105e36:	84 c0                	test   %al,%al
80105e38:	74 19                	je     80105e53 <uartinit+0xb3>
  if(!uart)
80105e3a:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80105e40:	85 d2                	test   %edx,%edx
80105e42:	74 ec                	je     80105e30 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105e44:	83 c3 01             	add    $0x1,%ebx
80105e47:	e8 04 ff ff ff       	call   80105d50 <uartputc.part.0>
80105e4c:	0f be 03             	movsbl (%ebx),%eax
80105e4f:	84 c0                	test   %al,%al
80105e51:	75 e7                	jne    80105e3a <uartinit+0x9a>
}
80105e53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e56:	5b                   	pop    %ebx
80105e57:	5e                   	pop    %esi
80105e58:	5f                   	pop    %edi
80105e59:	5d                   	pop    %ebp
80105e5a:	c3                   	ret    
80105e5b:	90                   	nop
80105e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e60 <uartputc>:
  if(!uart)
80105e60:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
{
80105e66:	55                   	push   %ebp
80105e67:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105e69:	85 d2                	test   %edx,%edx
{
80105e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105e6e:	74 10                	je     80105e80 <uartputc+0x20>
}
80105e70:	5d                   	pop    %ebp
80105e71:	e9 da fe ff ff       	jmp    80105d50 <uartputc.part.0>
80105e76:	8d 76 00             	lea    0x0(%esi),%esi
80105e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e80:	5d                   	pop    %ebp
80105e81:	c3                   	ret    
80105e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e90 <uartintr>:

void
uartintr(void)
{
80105e90:	55                   	push   %ebp
80105e91:	89 e5                	mov    %esp,%ebp
80105e93:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e96:	68 20 5d 10 80       	push   $0x80105d20
80105e9b:	e8 70 a9 ff ff       	call   80100810 <consoleintr>
}
80105ea0:	83 c4 10             	add    $0x10,%esp
80105ea3:	c9                   	leave  
80105ea4:	c3                   	ret    

80105ea5 <vector0>:
80105ea5:	6a 00                	push   $0x0
80105ea7:	6a 00                	push   $0x0
80105ea9:	e9 50 fb ff ff       	jmp    801059fe <alltraps>

80105eae <vector1>:
80105eae:	6a 00                	push   $0x0
80105eb0:	6a 01                	push   $0x1
80105eb2:	e9 47 fb ff ff       	jmp    801059fe <alltraps>

80105eb7 <vector2>:
80105eb7:	6a 00                	push   $0x0
80105eb9:	6a 02                	push   $0x2
80105ebb:	e9 3e fb ff ff       	jmp    801059fe <alltraps>

80105ec0 <vector3>:
80105ec0:	6a 00                	push   $0x0
80105ec2:	6a 03                	push   $0x3
80105ec4:	e9 35 fb ff ff       	jmp    801059fe <alltraps>

80105ec9 <vector4>:
80105ec9:	6a 00                	push   $0x0
80105ecb:	6a 04                	push   $0x4
80105ecd:	e9 2c fb ff ff       	jmp    801059fe <alltraps>

80105ed2 <vector5>:
80105ed2:	6a 00                	push   $0x0
80105ed4:	6a 05                	push   $0x5
80105ed6:	e9 23 fb ff ff       	jmp    801059fe <alltraps>

80105edb <vector6>:
80105edb:	6a 00                	push   $0x0
80105edd:	6a 06                	push   $0x6
80105edf:	e9 1a fb ff ff       	jmp    801059fe <alltraps>

80105ee4 <vector7>:
80105ee4:	6a 00                	push   $0x0
80105ee6:	6a 07                	push   $0x7
80105ee8:	e9 11 fb ff ff       	jmp    801059fe <alltraps>

80105eed <vector8>:
80105eed:	6a 08                	push   $0x8
80105eef:	e9 0a fb ff ff       	jmp    801059fe <alltraps>

80105ef4 <vector9>:
80105ef4:	6a 00                	push   $0x0
80105ef6:	6a 09                	push   $0x9
80105ef8:	e9 01 fb ff ff       	jmp    801059fe <alltraps>

80105efd <vector10>:
80105efd:	6a 0a                	push   $0xa
80105eff:	e9 fa fa ff ff       	jmp    801059fe <alltraps>

80105f04 <vector11>:
80105f04:	6a 0b                	push   $0xb
80105f06:	e9 f3 fa ff ff       	jmp    801059fe <alltraps>

80105f0b <vector12>:
80105f0b:	6a 0c                	push   $0xc
80105f0d:	e9 ec fa ff ff       	jmp    801059fe <alltraps>

80105f12 <vector13>:
80105f12:	6a 0d                	push   $0xd
80105f14:	e9 e5 fa ff ff       	jmp    801059fe <alltraps>

80105f19 <vector14>:
80105f19:	6a 0e                	push   $0xe
80105f1b:	e9 de fa ff ff       	jmp    801059fe <alltraps>

80105f20 <vector15>:
80105f20:	6a 00                	push   $0x0
80105f22:	6a 0f                	push   $0xf
80105f24:	e9 d5 fa ff ff       	jmp    801059fe <alltraps>

80105f29 <vector16>:
80105f29:	6a 00                	push   $0x0
80105f2b:	6a 10                	push   $0x10
80105f2d:	e9 cc fa ff ff       	jmp    801059fe <alltraps>

80105f32 <vector17>:
80105f32:	6a 11                	push   $0x11
80105f34:	e9 c5 fa ff ff       	jmp    801059fe <alltraps>

80105f39 <vector18>:
80105f39:	6a 00                	push   $0x0
80105f3b:	6a 12                	push   $0x12
80105f3d:	e9 bc fa ff ff       	jmp    801059fe <alltraps>

80105f42 <vector19>:
80105f42:	6a 00                	push   $0x0
80105f44:	6a 13                	push   $0x13
80105f46:	e9 b3 fa ff ff       	jmp    801059fe <alltraps>

80105f4b <vector20>:
80105f4b:	6a 00                	push   $0x0
80105f4d:	6a 14                	push   $0x14
80105f4f:	e9 aa fa ff ff       	jmp    801059fe <alltraps>

80105f54 <vector21>:
80105f54:	6a 00                	push   $0x0
80105f56:	6a 15                	push   $0x15
80105f58:	e9 a1 fa ff ff       	jmp    801059fe <alltraps>

80105f5d <vector22>:
80105f5d:	6a 00                	push   $0x0
80105f5f:	6a 16                	push   $0x16
80105f61:	e9 98 fa ff ff       	jmp    801059fe <alltraps>

80105f66 <vector23>:
80105f66:	6a 00                	push   $0x0
80105f68:	6a 17                	push   $0x17
80105f6a:	e9 8f fa ff ff       	jmp    801059fe <alltraps>

80105f6f <vector24>:
80105f6f:	6a 00                	push   $0x0
80105f71:	6a 18                	push   $0x18
80105f73:	e9 86 fa ff ff       	jmp    801059fe <alltraps>

80105f78 <vector25>:
80105f78:	6a 00                	push   $0x0
80105f7a:	6a 19                	push   $0x19
80105f7c:	e9 7d fa ff ff       	jmp    801059fe <alltraps>

80105f81 <vector26>:
80105f81:	6a 00                	push   $0x0
80105f83:	6a 1a                	push   $0x1a
80105f85:	e9 74 fa ff ff       	jmp    801059fe <alltraps>

80105f8a <vector27>:
80105f8a:	6a 00                	push   $0x0
80105f8c:	6a 1b                	push   $0x1b
80105f8e:	e9 6b fa ff ff       	jmp    801059fe <alltraps>

80105f93 <vector28>:
80105f93:	6a 00                	push   $0x0
80105f95:	6a 1c                	push   $0x1c
80105f97:	e9 62 fa ff ff       	jmp    801059fe <alltraps>

80105f9c <vector29>:
80105f9c:	6a 00                	push   $0x0
80105f9e:	6a 1d                	push   $0x1d
80105fa0:	e9 59 fa ff ff       	jmp    801059fe <alltraps>

80105fa5 <vector30>:
80105fa5:	6a 00                	push   $0x0
80105fa7:	6a 1e                	push   $0x1e
80105fa9:	e9 50 fa ff ff       	jmp    801059fe <alltraps>

80105fae <vector31>:
80105fae:	6a 00                	push   $0x0
80105fb0:	6a 1f                	push   $0x1f
80105fb2:	e9 47 fa ff ff       	jmp    801059fe <alltraps>

80105fb7 <vector32>:
80105fb7:	6a 00                	push   $0x0
80105fb9:	6a 20                	push   $0x20
80105fbb:	e9 3e fa ff ff       	jmp    801059fe <alltraps>

80105fc0 <vector33>:
80105fc0:	6a 00                	push   $0x0
80105fc2:	6a 21                	push   $0x21
80105fc4:	e9 35 fa ff ff       	jmp    801059fe <alltraps>

80105fc9 <vector34>:
80105fc9:	6a 00                	push   $0x0
80105fcb:	6a 22                	push   $0x22
80105fcd:	e9 2c fa ff ff       	jmp    801059fe <alltraps>

80105fd2 <vector35>:
80105fd2:	6a 00                	push   $0x0
80105fd4:	6a 23                	push   $0x23
80105fd6:	e9 23 fa ff ff       	jmp    801059fe <alltraps>

80105fdb <vector36>:
80105fdb:	6a 00                	push   $0x0
80105fdd:	6a 24                	push   $0x24
80105fdf:	e9 1a fa ff ff       	jmp    801059fe <alltraps>

80105fe4 <vector37>:
80105fe4:	6a 00                	push   $0x0
80105fe6:	6a 25                	push   $0x25
80105fe8:	e9 11 fa ff ff       	jmp    801059fe <alltraps>

80105fed <vector38>:
80105fed:	6a 00                	push   $0x0
80105fef:	6a 26                	push   $0x26
80105ff1:	e9 08 fa ff ff       	jmp    801059fe <alltraps>

80105ff6 <vector39>:
80105ff6:	6a 00                	push   $0x0
80105ff8:	6a 27                	push   $0x27
80105ffa:	e9 ff f9 ff ff       	jmp    801059fe <alltraps>

80105fff <vector40>:
80105fff:	6a 00                	push   $0x0
80106001:	6a 28                	push   $0x28
80106003:	e9 f6 f9 ff ff       	jmp    801059fe <alltraps>

80106008 <vector41>:
80106008:	6a 00                	push   $0x0
8010600a:	6a 29                	push   $0x29
8010600c:	e9 ed f9 ff ff       	jmp    801059fe <alltraps>

80106011 <vector42>:
80106011:	6a 00                	push   $0x0
80106013:	6a 2a                	push   $0x2a
80106015:	e9 e4 f9 ff ff       	jmp    801059fe <alltraps>

8010601a <vector43>:
8010601a:	6a 00                	push   $0x0
8010601c:	6a 2b                	push   $0x2b
8010601e:	e9 db f9 ff ff       	jmp    801059fe <alltraps>

80106023 <vector44>:
80106023:	6a 00                	push   $0x0
80106025:	6a 2c                	push   $0x2c
80106027:	e9 d2 f9 ff ff       	jmp    801059fe <alltraps>

8010602c <vector45>:
8010602c:	6a 00                	push   $0x0
8010602e:	6a 2d                	push   $0x2d
80106030:	e9 c9 f9 ff ff       	jmp    801059fe <alltraps>

80106035 <vector46>:
80106035:	6a 00                	push   $0x0
80106037:	6a 2e                	push   $0x2e
80106039:	e9 c0 f9 ff ff       	jmp    801059fe <alltraps>

8010603e <vector47>:
8010603e:	6a 00                	push   $0x0
80106040:	6a 2f                	push   $0x2f
80106042:	e9 b7 f9 ff ff       	jmp    801059fe <alltraps>

80106047 <vector48>:
80106047:	6a 00                	push   $0x0
80106049:	6a 30                	push   $0x30
8010604b:	e9 ae f9 ff ff       	jmp    801059fe <alltraps>

80106050 <vector49>:
80106050:	6a 00                	push   $0x0
80106052:	6a 31                	push   $0x31
80106054:	e9 a5 f9 ff ff       	jmp    801059fe <alltraps>

80106059 <vector50>:
80106059:	6a 00                	push   $0x0
8010605b:	6a 32                	push   $0x32
8010605d:	e9 9c f9 ff ff       	jmp    801059fe <alltraps>

80106062 <vector51>:
80106062:	6a 00                	push   $0x0
80106064:	6a 33                	push   $0x33
80106066:	e9 93 f9 ff ff       	jmp    801059fe <alltraps>

8010606b <vector52>:
8010606b:	6a 00                	push   $0x0
8010606d:	6a 34                	push   $0x34
8010606f:	e9 8a f9 ff ff       	jmp    801059fe <alltraps>

80106074 <vector53>:
80106074:	6a 00                	push   $0x0
80106076:	6a 35                	push   $0x35
80106078:	e9 81 f9 ff ff       	jmp    801059fe <alltraps>

8010607d <vector54>:
8010607d:	6a 00                	push   $0x0
8010607f:	6a 36                	push   $0x36
80106081:	e9 78 f9 ff ff       	jmp    801059fe <alltraps>

80106086 <vector55>:
80106086:	6a 00                	push   $0x0
80106088:	6a 37                	push   $0x37
8010608a:	e9 6f f9 ff ff       	jmp    801059fe <alltraps>

8010608f <vector56>:
8010608f:	6a 00                	push   $0x0
80106091:	6a 38                	push   $0x38
80106093:	e9 66 f9 ff ff       	jmp    801059fe <alltraps>

80106098 <vector57>:
80106098:	6a 00                	push   $0x0
8010609a:	6a 39                	push   $0x39
8010609c:	e9 5d f9 ff ff       	jmp    801059fe <alltraps>

801060a1 <vector58>:
801060a1:	6a 00                	push   $0x0
801060a3:	6a 3a                	push   $0x3a
801060a5:	e9 54 f9 ff ff       	jmp    801059fe <alltraps>

801060aa <vector59>:
801060aa:	6a 00                	push   $0x0
801060ac:	6a 3b                	push   $0x3b
801060ae:	e9 4b f9 ff ff       	jmp    801059fe <alltraps>

801060b3 <vector60>:
801060b3:	6a 00                	push   $0x0
801060b5:	6a 3c                	push   $0x3c
801060b7:	e9 42 f9 ff ff       	jmp    801059fe <alltraps>

801060bc <vector61>:
801060bc:	6a 00                	push   $0x0
801060be:	6a 3d                	push   $0x3d
801060c0:	e9 39 f9 ff ff       	jmp    801059fe <alltraps>

801060c5 <vector62>:
801060c5:	6a 00                	push   $0x0
801060c7:	6a 3e                	push   $0x3e
801060c9:	e9 30 f9 ff ff       	jmp    801059fe <alltraps>

801060ce <vector63>:
801060ce:	6a 00                	push   $0x0
801060d0:	6a 3f                	push   $0x3f
801060d2:	e9 27 f9 ff ff       	jmp    801059fe <alltraps>

801060d7 <vector64>:
801060d7:	6a 00                	push   $0x0
801060d9:	6a 40                	push   $0x40
801060db:	e9 1e f9 ff ff       	jmp    801059fe <alltraps>

801060e0 <vector65>:
801060e0:	6a 00                	push   $0x0
801060e2:	6a 41                	push   $0x41
801060e4:	e9 15 f9 ff ff       	jmp    801059fe <alltraps>

801060e9 <vector66>:
801060e9:	6a 00                	push   $0x0
801060eb:	6a 42                	push   $0x42
801060ed:	e9 0c f9 ff ff       	jmp    801059fe <alltraps>

801060f2 <vector67>:
801060f2:	6a 00                	push   $0x0
801060f4:	6a 43                	push   $0x43
801060f6:	e9 03 f9 ff ff       	jmp    801059fe <alltraps>

801060fb <vector68>:
801060fb:	6a 00                	push   $0x0
801060fd:	6a 44                	push   $0x44
801060ff:	e9 fa f8 ff ff       	jmp    801059fe <alltraps>

80106104 <vector69>:
80106104:	6a 00                	push   $0x0
80106106:	6a 45                	push   $0x45
80106108:	e9 f1 f8 ff ff       	jmp    801059fe <alltraps>

8010610d <vector70>:
8010610d:	6a 00                	push   $0x0
8010610f:	6a 46                	push   $0x46
80106111:	e9 e8 f8 ff ff       	jmp    801059fe <alltraps>

80106116 <vector71>:
80106116:	6a 00                	push   $0x0
80106118:	6a 47                	push   $0x47
8010611a:	e9 df f8 ff ff       	jmp    801059fe <alltraps>

8010611f <vector72>:
8010611f:	6a 00                	push   $0x0
80106121:	6a 48                	push   $0x48
80106123:	e9 d6 f8 ff ff       	jmp    801059fe <alltraps>

80106128 <vector73>:
80106128:	6a 00                	push   $0x0
8010612a:	6a 49                	push   $0x49
8010612c:	e9 cd f8 ff ff       	jmp    801059fe <alltraps>

80106131 <vector74>:
80106131:	6a 00                	push   $0x0
80106133:	6a 4a                	push   $0x4a
80106135:	e9 c4 f8 ff ff       	jmp    801059fe <alltraps>

8010613a <vector75>:
8010613a:	6a 00                	push   $0x0
8010613c:	6a 4b                	push   $0x4b
8010613e:	e9 bb f8 ff ff       	jmp    801059fe <alltraps>

80106143 <vector76>:
80106143:	6a 00                	push   $0x0
80106145:	6a 4c                	push   $0x4c
80106147:	e9 b2 f8 ff ff       	jmp    801059fe <alltraps>

8010614c <vector77>:
8010614c:	6a 00                	push   $0x0
8010614e:	6a 4d                	push   $0x4d
80106150:	e9 a9 f8 ff ff       	jmp    801059fe <alltraps>

80106155 <vector78>:
80106155:	6a 00                	push   $0x0
80106157:	6a 4e                	push   $0x4e
80106159:	e9 a0 f8 ff ff       	jmp    801059fe <alltraps>

8010615e <vector79>:
8010615e:	6a 00                	push   $0x0
80106160:	6a 4f                	push   $0x4f
80106162:	e9 97 f8 ff ff       	jmp    801059fe <alltraps>

80106167 <vector80>:
80106167:	6a 00                	push   $0x0
80106169:	6a 50                	push   $0x50
8010616b:	e9 8e f8 ff ff       	jmp    801059fe <alltraps>

80106170 <vector81>:
80106170:	6a 00                	push   $0x0
80106172:	6a 51                	push   $0x51
80106174:	e9 85 f8 ff ff       	jmp    801059fe <alltraps>

80106179 <vector82>:
80106179:	6a 00                	push   $0x0
8010617b:	6a 52                	push   $0x52
8010617d:	e9 7c f8 ff ff       	jmp    801059fe <alltraps>

80106182 <vector83>:
80106182:	6a 00                	push   $0x0
80106184:	6a 53                	push   $0x53
80106186:	e9 73 f8 ff ff       	jmp    801059fe <alltraps>

8010618b <vector84>:
8010618b:	6a 00                	push   $0x0
8010618d:	6a 54                	push   $0x54
8010618f:	e9 6a f8 ff ff       	jmp    801059fe <alltraps>

80106194 <vector85>:
80106194:	6a 00                	push   $0x0
80106196:	6a 55                	push   $0x55
80106198:	e9 61 f8 ff ff       	jmp    801059fe <alltraps>

8010619d <vector86>:
8010619d:	6a 00                	push   $0x0
8010619f:	6a 56                	push   $0x56
801061a1:	e9 58 f8 ff ff       	jmp    801059fe <alltraps>

801061a6 <vector87>:
801061a6:	6a 00                	push   $0x0
801061a8:	6a 57                	push   $0x57
801061aa:	e9 4f f8 ff ff       	jmp    801059fe <alltraps>

801061af <vector88>:
801061af:	6a 00                	push   $0x0
801061b1:	6a 58                	push   $0x58
801061b3:	e9 46 f8 ff ff       	jmp    801059fe <alltraps>

801061b8 <vector89>:
801061b8:	6a 00                	push   $0x0
801061ba:	6a 59                	push   $0x59
801061bc:	e9 3d f8 ff ff       	jmp    801059fe <alltraps>

801061c1 <vector90>:
801061c1:	6a 00                	push   $0x0
801061c3:	6a 5a                	push   $0x5a
801061c5:	e9 34 f8 ff ff       	jmp    801059fe <alltraps>

801061ca <vector91>:
801061ca:	6a 00                	push   $0x0
801061cc:	6a 5b                	push   $0x5b
801061ce:	e9 2b f8 ff ff       	jmp    801059fe <alltraps>

801061d3 <vector92>:
801061d3:	6a 00                	push   $0x0
801061d5:	6a 5c                	push   $0x5c
801061d7:	e9 22 f8 ff ff       	jmp    801059fe <alltraps>

801061dc <vector93>:
801061dc:	6a 00                	push   $0x0
801061de:	6a 5d                	push   $0x5d
801061e0:	e9 19 f8 ff ff       	jmp    801059fe <alltraps>

801061e5 <vector94>:
801061e5:	6a 00                	push   $0x0
801061e7:	6a 5e                	push   $0x5e
801061e9:	e9 10 f8 ff ff       	jmp    801059fe <alltraps>

801061ee <vector95>:
801061ee:	6a 00                	push   $0x0
801061f0:	6a 5f                	push   $0x5f
801061f2:	e9 07 f8 ff ff       	jmp    801059fe <alltraps>

801061f7 <vector96>:
801061f7:	6a 00                	push   $0x0
801061f9:	6a 60                	push   $0x60
801061fb:	e9 fe f7 ff ff       	jmp    801059fe <alltraps>

80106200 <vector97>:
80106200:	6a 00                	push   $0x0
80106202:	6a 61                	push   $0x61
80106204:	e9 f5 f7 ff ff       	jmp    801059fe <alltraps>

80106209 <vector98>:
80106209:	6a 00                	push   $0x0
8010620b:	6a 62                	push   $0x62
8010620d:	e9 ec f7 ff ff       	jmp    801059fe <alltraps>

80106212 <vector99>:
80106212:	6a 00                	push   $0x0
80106214:	6a 63                	push   $0x63
80106216:	e9 e3 f7 ff ff       	jmp    801059fe <alltraps>

8010621b <vector100>:
8010621b:	6a 00                	push   $0x0
8010621d:	6a 64                	push   $0x64
8010621f:	e9 da f7 ff ff       	jmp    801059fe <alltraps>

80106224 <vector101>:
80106224:	6a 00                	push   $0x0
80106226:	6a 65                	push   $0x65
80106228:	e9 d1 f7 ff ff       	jmp    801059fe <alltraps>

8010622d <vector102>:
8010622d:	6a 00                	push   $0x0
8010622f:	6a 66                	push   $0x66
80106231:	e9 c8 f7 ff ff       	jmp    801059fe <alltraps>

80106236 <vector103>:
80106236:	6a 00                	push   $0x0
80106238:	6a 67                	push   $0x67
8010623a:	e9 bf f7 ff ff       	jmp    801059fe <alltraps>

8010623f <vector104>:
8010623f:	6a 00                	push   $0x0
80106241:	6a 68                	push   $0x68
80106243:	e9 b6 f7 ff ff       	jmp    801059fe <alltraps>

80106248 <vector105>:
80106248:	6a 00                	push   $0x0
8010624a:	6a 69                	push   $0x69
8010624c:	e9 ad f7 ff ff       	jmp    801059fe <alltraps>

80106251 <vector106>:
80106251:	6a 00                	push   $0x0
80106253:	6a 6a                	push   $0x6a
80106255:	e9 a4 f7 ff ff       	jmp    801059fe <alltraps>

8010625a <vector107>:
8010625a:	6a 00                	push   $0x0
8010625c:	6a 6b                	push   $0x6b
8010625e:	e9 9b f7 ff ff       	jmp    801059fe <alltraps>

80106263 <vector108>:
80106263:	6a 00                	push   $0x0
80106265:	6a 6c                	push   $0x6c
80106267:	e9 92 f7 ff ff       	jmp    801059fe <alltraps>

8010626c <vector109>:
8010626c:	6a 00                	push   $0x0
8010626e:	6a 6d                	push   $0x6d
80106270:	e9 89 f7 ff ff       	jmp    801059fe <alltraps>

80106275 <vector110>:
80106275:	6a 00                	push   $0x0
80106277:	6a 6e                	push   $0x6e
80106279:	e9 80 f7 ff ff       	jmp    801059fe <alltraps>

8010627e <vector111>:
8010627e:	6a 00                	push   $0x0
80106280:	6a 6f                	push   $0x6f
80106282:	e9 77 f7 ff ff       	jmp    801059fe <alltraps>

80106287 <vector112>:
80106287:	6a 00                	push   $0x0
80106289:	6a 70                	push   $0x70
8010628b:	e9 6e f7 ff ff       	jmp    801059fe <alltraps>

80106290 <vector113>:
80106290:	6a 00                	push   $0x0
80106292:	6a 71                	push   $0x71
80106294:	e9 65 f7 ff ff       	jmp    801059fe <alltraps>

80106299 <vector114>:
80106299:	6a 00                	push   $0x0
8010629b:	6a 72                	push   $0x72
8010629d:	e9 5c f7 ff ff       	jmp    801059fe <alltraps>

801062a2 <vector115>:
801062a2:	6a 00                	push   $0x0
801062a4:	6a 73                	push   $0x73
801062a6:	e9 53 f7 ff ff       	jmp    801059fe <alltraps>

801062ab <vector116>:
801062ab:	6a 00                	push   $0x0
801062ad:	6a 74                	push   $0x74
801062af:	e9 4a f7 ff ff       	jmp    801059fe <alltraps>

801062b4 <vector117>:
801062b4:	6a 00                	push   $0x0
801062b6:	6a 75                	push   $0x75
801062b8:	e9 41 f7 ff ff       	jmp    801059fe <alltraps>

801062bd <vector118>:
801062bd:	6a 00                	push   $0x0
801062bf:	6a 76                	push   $0x76
801062c1:	e9 38 f7 ff ff       	jmp    801059fe <alltraps>

801062c6 <vector119>:
801062c6:	6a 00                	push   $0x0
801062c8:	6a 77                	push   $0x77
801062ca:	e9 2f f7 ff ff       	jmp    801059fe <alltraps>

801062cf <vector120>:
801062cf:	6a 00                	push   $0x0
801062d1:	6a 78                	push   $0x78
801062d3:	e9 26 f7 ff ff       	jmp    801059fe <alltraps>

801062d8 <vector121>:
801062d8:	6a 00                	push   $0x0
801062da:	6a 79                	push   $0x79
801062dc:	e9 1d f7 ff ff       	jmp    801059fe <alltraps>

801062e1 <vector122>:
801062e1:	6a 00                	push   $0x0
801062e3:	6a 7a                	push   $0x7a
801062e5:	e9 14 f7 ff ff       	jmp    801059fe <alltraps>

801062ea <vector123>:
801062ea:	6a 00                	push   $0x0
801062ec:	6a 7b                	push   $0x7b
801062ee:	e9 0b f7 ff ff       	jmp    801059fe <alltraps>

801062f3 <vector124>:
801062f3:	6a 00                	push   $0x0
801062f5:	6a 7c                	push   $0x7c
801062f7:	e9 02 f7 ff ff       	jmp    801059fe <alltraps>

801062fc <vector125>:
801062fc:	6a 00                	push   $0x0
801062fe:	6a 7d                	push   $0x7d
80106300:	e9 f9 f6 ff ff       	jmp    801059fe <alltraps>

80106305 <vector126>:
80106305:	6a 00                	push   $0x0
80106307:	6a 7e                	push   $0x7e
80106309:	e9 f0 f6 ff ff       	jmp    801059fe <alltraps>

8010630e <vector127>:
8010630e:	6a 00                	push   $0x0
80106310:	6a 7f                	push   $0x7f
80106312:	e9 e7 f6 ff ff       	jmp    801059fe <alltraps>

80106317 <vector128>:
80106317:	6a 00                	push   $0x0
80106319:	68 80 00 00 00       	push   $0x80
8010631e:	e9 db f6 ff ff       	jmp    801059fe <alltraps>

80106323 <vector129>:
80106323:	6a 00                	push   $0x0
80106325:	68 81 00 00 00       	push   $0x81
8010632a:	e9 cf f6 ff ff       	jmp    801059fe <alltraps>

8010632f <vector130>:
8010632f:	6a 00                	push   $0x0
80106331:	68 82 00 00 00       	push   $0x82
80106336:	e9 c3 f6 ff ff       	jmp    801059fe <alltraps>

8010633b <vector131>:
8010633b:	6a 00                	push   $0x0
8010633d:	68 83 00 00 00       	push   $0x83
80106342:	e9 b7 f6 ff ff       	jmp    801059fe <alltraps>

80106347 <vector132>:
80106347:	6a 00                	push   $0x0
80106349:	68 84 00 00 00       	push   $0x84
8010634e:	e9 ab f6 ff ff       	jmp    801059fe <alltraps>

80106353 <vector133>:
80106353:	6a 00                	push   $0x0
80106355:	68 85 00 00 00       	push   $0x85
8010635a:	e9 9f f6 ff ff       	jmp    801059fe <alltraps>

8010635f <vector134>:
8010635f:	6a 00                	push   $0x0
80106361:	68 86 00 00 00       	push   $0x86
80106366:	e9 93 f6 ff ff       	jmp    801059fe <alltraps>

8010636b <vector135>:
8010636b:	6a 00                	push   $0x0
8010636d:	68 87 00 00 00       	push   $0x87
80106372:	e9 87 f6 ff ff       	jmp    801059fe <alltraps>

80106377 <vector136>:
80106377:	6a 00                	push   $0x0
80106379:	68 88 00 00 00       	push   $0x88
8010637e:	e9 7b f6 ff ff       	jmp    801059fe <alltraps>

80106383 <vector137>:
80106383:	6a 00                	push   $0x0
80106385:	68 89 00 00 00       	push   $0x89
8010638a:	e9 6f f6 ff ff       	jmp    801059fe <alltraps>

8010638f <vector138>:
8010638f:	6a 00                	push   $0x0
80106391:	68 8a 00 00 00       	push   $0x8a
80106396:	e9 63 f6 ff ff       	jmp    801059fe <alltraps>

8010639b <vector139>:
8010639b:	6a 00                	push   $0x0
8010639d:	68 8b 00 00 00       	push   $0x8b
801063a2:	e9 57 f6 ff ff       	jmp    801059fe <alltraps>

801063a7 <vector140>:
801063a7:	6a 00                	push   $0x0
801063a9:	68 8c 00 00 00       	push   $0x8c
801063ae:	e9 4b f6 ff ff       	jmp    801059fe <alltraps>

801063b3 <vector141>:
801063b3:	6a 00                	push   $0x0
801063b5:	68 8d 00 00 00       	push   $0x8d
801063ba:	e9 3f f6 ff ff       	jmp    801059fe <alltraps>

801063bf <vector142>:
801063bf:	6a 00                	push   $0x0
801063c1:	68 8e 00 00 00       	push   $0x8e
801063c6:	e9 33 f6 ff ff       	jmp    801059fe <alltraps>

801063cb <vector143>:
801063cb:	6a 00                	push   $0x0
801063cd:	68 8f 00 00 00       	push   $0x8f
801063d2:	e9 27 f6 ff ff       	jmp    801059fe <alltraps>

801063d7 <vector144>:
801063d7:	6a 00                	push   $0x0
801063d9:	68 90 00 00 00       	push   $0x90
801063de:	e9 1b f6 ff ff       	jmp    801059fe <alltraps>

801063e3 <vector145>:
801063e3:	6a 00                	push   $0x0
801063e5:	68 91 00 00 00       	push   $0x91
801063ea:	e9 0f f6 ff ff       	jmp    801059fe <alltraps>

801063ef <vector146>:
801063ef:	6a 00                	push   $0x0
801063f1:	68 92 00 00 00       	push   $0x92
801063f6:	e9 03 f6 ff ff       	jmp    801059fe <alltraps>

801063fb <vector147>:
801063fb:	6a 00                	push   $0x0
801063fd:	68 93 00 00 00       	push   $0x93
80106402:	e9 f7 f5 ff ff       	jmp    801059fe <alltraps>

80106407 <vector148>:
80106407:	6a 00                	push   $0x0
80106409:	68 94 00 00 00       	push   $0x94
8010640e:	e9 eb f5 ff ff       	jmp    801059fe <alltraps>

80106413 <vector149>:
80106413:	6a 00                	push   $0x0
80106415:	68 95 00 00 00       	push   $0x95
8010641a:	e9 df f5 ff ff       	jmp    801059fe <alltraps>

8010641f <vector150>:
8010641f:	6a 00                	push   $0x0
80106421:	68 96 00 00 00       	push   $0x96
80106426:	e9 d3 f5 ff ff       	jmp    801059fe <alltraps>

8010642b <vector151>:
8010642b:	6a 00                	push   $0x0
8010642d:	68 97 00 00 00       	push   $0x97
80106432:	e9 c7 f5 ff ff       	jmp    801059fe <alltraps>

80106437 <vector152>:
80106437:	6a 00                	push   $0x0
80106439:	68 98 00 00 00       	push   $0x98
8010643e:	e9 bb f5 ff ff       	jmp    801059fe <alltraps>

80106443 <vector153>:
80106443:	6a 00                	push   $0x0
80106445:	68 99 00 00 00       	push   $0x99
8010644a:	e9 af f5 ff ff       	jmp    801059fe <alltraps>

8010644f <vector154>:
8010644f:	6a 00                	push   $0x0
80106451:	68 9a 00 00 00       	push   $0x9a
80106456:	e9 a3 f5 ff ff       	jmp    801059fe <alltraps>

8010645b <vector155>:
8010645b:	6a 00                	push   $0x0
8010645d:	68 9b 00 00 00       	push   $0x9b
80106462:	e9 97 f5 ff ff       	jmp    801059fe <alltraps>

80106467 <vector156>:
80106467:	6a 00                	push   $0x0
80106469:	68 9c 00 00 00       	push   $0x9c
8010646e:	e9 8b f5 ff ff       	jmp    801059fe <alltraps>

80106473 <vector157>:
80106473:	6a 00                	push   $0x0
80106475:	68 9d 00 00 00       	push   $0x9d
8010647a:	e9 7f f5 ff ff       	jmp    801059fe <alltraps>

8010647f <vector158>:
8010647f:	6a 00                	push   $0x0
80106481:	68 9e 00 00 00       	push   $0x9e
80106486:	e9 73 f5 ff ff       	jmp    801059fe <alltraps>

8010648b <vector159>:
8010648b:	6a 00                	push   $0x0
8010648d:	68 9f 00 00 00       	push   $0x9f
80106492:	e9 67 f5 ff ff       	jmp    801059fe <alltraps>

80106497 <vector160>:
80106497:	6a 00                	push   $0x0
80106499:	68 a0 00 00 00       	push   $0xa0
8010649e:	e9 5b f5 ff ff       	jmp    801059fe <alltraps>

801064a3 <vector161>:
801064a3:	6a 00                	push   $0x0
801064a5:	68 a1 00 00 00       	push   $0xa1
801064aa:	e9 4f f5 ff ff       	jmp    801059fe <alltraps>

801064af <vector162>:
801064af:	6a 00                	push   $0x0
801064b1:	68 a2 00 00 00       	push   $0xa2
801064b6:	e9 43 f5 ff ff       	jmp    801059fe <alltraps>

801064bb <vector163>:
801064bb:	6a 00                	push   $0x0
801064bd:	68 a3 00 00 00       	push   $0xa3
801064c2:	e9 37 f5 ff ff       	jmp    801059fe <alltraps>

801064c7 <vector164>:
801064c7:	6a 00                	push   $0x0
801064c9:	68 a4 00 00 00       	push   $0xa4
801064ce:	e9 2b f5 ff ff       	jmp    801059fe <alltraps>

801064d3 <vector165>:
801064d3:	6a 00                	push   $0x0
801064d5:	68 a5 00 00 00       	push   $0xa5
801064da:	e9 1f f5 ff ff       	jmp    801059fe <alltraps>

801064df <vector166>:
801064df:	6a 00                	push   $0x0
801064e1:	68 a6 00 00 00       	push   $0xa6
801064e6:	e9 13 f5 ff ff       	jmp    801059fe <alltraps>

801064eb <vector167>:
801064eb:	6a 00                	push   $0x0
801064ed:	68 a7 00 00 00       	push   $0xa7
801064f2:	e9 07 f5 ff ff       	jmp    801059fe <alltraps>

801064f7 <vector168>:
801064f7:	6a 00                	push   $0x0
801064f9:	68 a8 00 00 00       	push   $0xa8
801064fe:	e9 fb f4 ff ff       	jmp    801059fe <alltraps>

80106503 <vector169>:
80106503:	6a 00                	push   $0x0
80106505:	68 a9 00 00 00       	push   $0xa9
8010650a:	e9 ef f4 ff ff       	jmp    801059fe <alltraps>

8010650f <vector170>:
8010650f:	6a 00                	push   $0x0
80106511:	68 aa 00 00 00       	push   $0xaa
80106516:	e9 e3 f4 ff ff       	jmp    801059fe <alltraps>

8010651b <vector171>:
8010651b:	6a 00                	push   $0x0
8010651d:	68 ab 00 00 00       	push   $0xab
80106522:	e9 d7 f4 ff ff       	jmp    801059fe <alltraps>

80106527 <vector172>:
80106527:	6a 00                	push   $0x0
80106529:	68 ac 00 00 00       	push   $0xac
8010652e:	e9 cb f4 ff ff       	jmp    801059fe <alltraps>

80106533 <vector173>:
80106533:	6a 00                	push   $0x0
80106535:	68 ad 00 00 00       	push   $0xad
8010653a:	e9 bf f4 ff ff       	jmp    801059fe <alltraps>

8010653f <vector174>:
8010653f:	6a 00                	push   $0x0
80106541:	68 ae 00 00 00       	push   $0xae
80106546:	e9 b3 f4 ff ff       	jmp    801059fe <alltraps>

8010654b <vector175>:
8010654b:	6a 00                	push   $0x0
8010654d:	68 af 00 00 00       	push   $0xaf
80106552:	e9 a7 f4 ff ff       	jmp    801059fe <alltraps>

80106557 <vector176>:
80106557:	6a 00                	push   $0x0
80106559:	68 b0 00 00 00       	push   $0xb0
8010655e:	e9 9b f4 ff ff       	jmp    801059fe <alltraps>

80106563 <vector177>:
80106563:	6a 00                	push   $0x0
80106565:	68 b1 00 00 00       	push   $0xb1
8010656a:	e9 8f f4 ff ff       	jmp    801059fe <alltraps>

8010656f <vector178>:
8010656f:	6a 00                	push   $0x0
80106571:	68 b2 00 00 00       	push   $0xb2
80106576:	e9 83 f4 ff ff       	jmp    801059fe <alltraps>

8010657b <vector179>:
8010657b:	6a 00                	push   $0x0
8010657d:	68 b3 00 00 00       	push   $0xb3
80106582:	e9 77 f4 ff ff       	jmp    801059fe <alltraps>

80106587 <vector180>:
80106587:	6a 00                	push   $0x0
80106589:	68 b4 00 00 00       	push   $0xb4
8010658e:	e9 6b f4 ff ff       	jmp    801059fe <alltraps>

80106593 <vector181>:
80106593:	6a 00                	push   $0x0
80106595:	68 b5 00 00 00       	push   $0xb5
8010659a:	e9 5f f4 ff ff       	jmp    801059fe <alltraps>

8010659f <vector182>:
8010659f:	6a 00                	push   $0x0
801065a1:	68 b6 00 00 00       	push   $0xb6
801065a6:	e9 53 f4 ff ff       	jmp    801059fe <alltraps>

801065ab <vector183>:
801065ab:	6a 00                	push   $0x0
801065ad:	68 b7 00 00 00       	push   $0xb7
801065b2:	e9 47 f4 ff ff       	jmp    801059fe <alltraps>

801065b7 <vector184>:
801065b7:	6a 00                	push   $0x0
801065b9:	68 b8 00 00 00       	push   $0xb8
801065be:	e9 3b f4 ff ff       	jmp    801059fe <alltraps>

801065c3 <vector185>:
801065c3:	6a 00                	push   $0x0
801065c5:	68 b9 00 00 00       	push   $0xb9
801065ca:	e9 2f f4 ff ff       	jmp    801059fe <alltraps>

801065cf <vector186>:
801065cf:	6a 00                	push   $0x0
801065d1:	68 ba 00 00 00       	push   $0xba
801065d6:	e9 23 f4 ff ff       	jmp    801059fe <alltraps>

801065db <vector187>:
801065db:	6a 00                	push   $0x0
801065dd:	68 bb 00 00 00       	push   $0xbb
801065e2:	e9 17 f4 ff ff       	jmp    801059fe <alltraps>

801065e7 <vector188>:
801065e7:	6a 00                	push   $0x0
801065e9:	68 bc 00 00 00       	push   $0xbc
801065ee:	e9 0b f4 ff ff       	jmp    801059fe <alltraps>

801065f3 <vector189>:
801065f3:	6a 00                	push   $0x0
801065f5:	68 bd 00 00 00       	push   $0xbd
801065fa:	e9 ff f3 ff ff       	jmp    801059fe <alltraps>

801065ff <vector190>:
801065ff:	6a 00                	push   $0x0
80106601:	68 be 00 00 00       	push   $0xbe
80106606:	e9 f3 f3 ff ff       	jmp    801059fe <alltraps>

8010660b <vector191>:
8010660b:	6a 00                	push   $0x0
8010660d:	68 bf 00 00 00       	push   $0xbf
80106612:	e9 e7 f3 ff ff       	jmp    801059fe <alltraps>

80106617 <vector192>:
80106617:	6a 00                	push   $0x0
80106619:	68 c0 00 00 00       	push   $0xc0
8010661e:	e9 db f3 ff ff       	jmp    801059fe <alltraps>

80106623 <vector193>:
80106623:	6a 00                	push   $0x0
80106625:	68 c1 00 00 00       	push   $0xc1
8010662a:	e9 cf f3 ff ff       	jmp    801059fe <alltraps>

8010662f <vector194>:
8010662f:	6a 00                	push   $0x0
80106631:	68 c2 00 00 00       	push   $0xc2
80106636:	e9 c3 f3 ff ff       	jmp    801059fe <alltraps>

8010663b <vector195>:
8010663b:	6a 00                	push   $0x0
8010663d:	68 c3 00 00 00       	push   $0xc3
80106642:	e9 b7 f3 ff ff       	jmp    801059fe <alltraps>

80106647 <vector196>:
80106647:	6a 00                	push   $0x0
80106649:	68 c4 00 00 00       	push   $0xc4
8010664e:	e9 ab f3 ff ff       	jmp    801059fe <alltraps>

80106653 <vector197>:
80106653:	6a 00                	push   $0x0
80106655:	68 c5 00 00 00       	push   $0xc5
8010665a:	e9 9f f3 ff ff       	jmp    801059fe <alltraps>

8010665f <vector198>:
8010665f:	6a 00                	push   $0x0
80106661:	68 c6 00 00 00       	push   $0xc6
80106666:	e9 93 f3 ff ff       	jmp    801059fe <alltraps>

8010666b <vector199>:
8010666b:	6a 00                	push   $0x0
8010666d:	68 c7 00 00 00       	push   $0xc7
80106672:	e9 87 f3 ff ff       	jmp    801059fe <alltraps>

80106677 <vector200>:
80106677:	6a 00                	push   $0x0
80106679:	68 c8 00 00 00       	push   $0xc8
8010667e:	e9 7b f3 ff ff       	jmp    801059fe <alltraps>

80106683 <vector201>:
80106683:	6a 00                	push   $0x0
80106685:	68 c9 00 00 00       	push   $0xc9
8010668a:	e9 6f f3 ff ff       	jmp    801059fe <alltraps>

8010668f <vector202>:
8010668f:	6a 00                	push   $0x0
80106691:	68 ca 00 00 00       	push   $0xca
80106696:	e9 63 f3 ff ff       	jmp    801059fe <alltraps>

8010669b <vector203>:
8010669b:	6a 00                	push   $0x0
8010669d:	68 cb 00 00 00       	push   $0xcb
801066a2:	e9 57 f3 ff ff       	jmp    801059fe <alltraps>

801066a7 <vector204>:
801066a7:	6a 00                	push   $0x0
801066a9:	68 cc 00 00 00       	push   $0xcc
801066ae:	e9 4b f3 ff ff       	jmp    801059fe <alltraps>

801066b3 <vector205>:
801066b3:	6a 00                	push   $0x0
801066b5:	68 cd 00 00 00       	push   $0xcd
801066ba:	e9 3f f3 ff ff       	jmp    801059fe <alltraps>

801066bf <vector206>:
801066bf:	6a 00                	push   $0x0
801066c1:	68 ce 00 00 00       	push   $0xce
801066c6:	e9 33 f3 ff ff       	jmp    801059fe <alltraps>

801066cb <vector207>:
801066cb:	6a 00                	push   $0x0
801066cd:	68 cf 00 00 00       	push   $0xcf
801066d2:	e9 27 f3 ff ff       	jmp    801059fe <alltraps>

801066d7 <vector208>:
801066d7:	6a 00                	push   $0x0
801066d9:	68 d0 00 00 00       	push   $0xd0
801066de:	e9 1b f3 ff ff       	jmp    801059fe <alltraps>

801066e3 <vector209>:
801066e3:	6a 00                	push   $0x0
801066e5:	68 d1 00 00 00       	push   $0xd1
801066ea:	e9 0f f3 ff ff       	jmp    801059fe <alltraps>

801066ef <vector210>:
801066ef:	6a 00                	push   $0x0
801066f1:	68 d2 00 00 00       	push   $0xd2
801066f6:	e9 03 f3 ff ff       	jmp    801059fe <alltraps>

801066fb <vector211>:
801066fb:	6a 00                	push   $0x0
801066fd:	68 d3 00 00 00       	push   $0xd3
80106702:	e9 f7 f2 ff ff       	jmp    801059fe <alltraps>

80106707 <vector212>:
80106707:	6a 00                	push   $0x0
80106709:	68 d4 00 00 00       	push   $0xd4
8010670e:	e9 eb f2 ff ff       	jmp    801059fe <alltraps>

80106713 <vector213>:
80106713:	6a 00                	push   $0x0
80106715:	68 d5 00 00 00       	push   $0xd5
8010671a:	e9 df f2 ff ff       	jmp    801059fe <alltraps>

8010671f <vector214>:
8010671f:	6a 00                	push   $0x0
80106721:	68 d6 00 00 00       	push   $0xd6
80106726:	e9 d3 f2 ff ff       	jmp    801059fe <alltraps>

8010672b <vector215>:
8010672b:	6a 00                	push   $0x0
8010672d:	68 d7 00 00 00       	push   $0xd7
80106732:	e9 c7 f2 ff ff       	jmp    801059fe <alltraps>

80106737 <vector216>:
80106737:	6a 00                	push   $0x0
80106739:	68 d8 00 00 00       	push   $0xd8
8010673e:	e9 bb f2 ff ff       	jmp    801059fe <alltraps>

80106743 <vector217>:
80106743:	6a 00                	push   $0x0
80106745:	68 d9 00 00 00       	push   $0xd9
8010674a:	e9 af f2 ff ff       	jmp    801059fe <alltraps>

8010674f <vector218>:
8010674f:	6a 00                	push   $0x0
80106751:	68 da 00 00 00       	push   $0xda
80106756:	e9 a3 f2 ff ff       	jmp    801059fe <alltraps>

8010675b <vector219>:
8010675b:	6a 00                	push   $0x0
8010675d:	68 db 00 00 00       	push   $0xdb
80106762:	e9 97 f2 ff ff       	jmp    801059fe <alltraps>

80106767 <vector220>:
80106767:	6a 00                	push   $0x0
80106769:	68 dc 00 00 00       	push   $0xdc
8010676e:	e9 8b f2 ff ff       	jmp    801059fe <alltraps>

80106773 <vector221>:
80106773:	6a 00                	push   $0x0
80106775:	68 dd 00 00 00       	push   $0xdd
8010677a:	e9 7f f2 ff ff       	jmp    801059fe <alltraps>

8010677f <vector222>:
8010677f:	6a 00                	push   $0x0
80106781:	68 de 00 00 00       	push   $0xde
80106786:	e9 73 f2 ff ff       	jmp    801059fe <alltraps>

8010678b <vector223>:
8010678b:	6a 00                	push   $0x0
8010678d:	68 df 00 00 00       	push   $0xdf
80106792:	e9 67 f2 ff ff       	jmp    801059fe <alltraps>

80106797 <vector224>:
80106797:	6a 00                	push   $0x0
80106799:	68 e0 00 00 00       	push   $0xe0
8010679e:	e9 5b f2 ff ff       	jmp    801059fe <alltraps>

801067a3 <vector225>:
801067a3:	6a 00                	push   $0x0
801067a5:	68 e1 00 00 00       	push   $0xe1
801067aa:	e9 4f f2 ff ff       	jmp    801059fe <alltraps>

801067af <vector226>:
801067af:	6a 00                	push   $0x0
801067b1:	68 e2 00 00 00       	push   $0xe2
801067b6:	e9 43 f2 ff ff       	jmp    801059fe <alltraps>

801067bb <vector227>:
801067bb:	6a 00                	push   $0x0
801067bd:	68 e3 00 00 00       	push   $0xe3
801067c2:	e9 37 f2 ff ff       	jmp    801059fe <alltraps>

801067c7 <vector228>:
801067c7:	6a 00                	push   $0x0
801067c9:	68 e4 00 00 00       	push   $0xe4
801067ce:	e9 2b f2 ff ff       	jmp    801059fe <alltraps>

801067d3 <vector229>:
801067d3:	6a 00                	push   $0x0
801067d5:	68 e5 00 00 00       	push   $0xe5
801067da:	e9 1f f2 ff ff       	jmp    801059fe <alltraps>

801067df <vector230>:
801067df:	6a 00                	push   $0x0
801067e1:	68 e6 00 00 00       	push   $0xe6
801067e6:	e9 13 f2 ff ff       	jmp    801059fe <alltraps>

801067eb <vector231>:
801067eb:	6a 00                	push   $0x0
801067ed:	68 e7 00 00 00       	push   $0xe7
801067f2:	e9 07 f2 ff ff       	jmp    801059fe <alltraps>

801067f7 <vector232>:
801067f7:	6a 00                	push   $0x0
801067f9:	68 e8 00 00 00       	push   $0xe8
801067fe:	e9 fb f1 ff ff       	jmp    801059fe <alltraps>

80106803 <vector233>:
80106803:	6a 00                	push   $0x0
80106805:	68 e9 00 00 00       	push   $0xe9
8010680a:	e9 ef f1 ff ff       	jmp    801059fe <alltraps>

8010680f <vector234>:
8010680f:	6a 00                	push   $0x0
80106811:	68 ea 00 00 00       	push   $0xea
80106816:	e9 e3 f1 ff ff       	jmp    801059fe <alltraps>

8010681b <vector235>:
8010681b:	6a 00                	push   $0x0
8010681d:	68 eb 00 00 00       	push   $0xeb
80106822:	e9 d7 f1 ff ff       	jmp    801059fe <alltraps>

80106827 <vector236>:
80106827:	6a 00                	push   $0x0
80106829:	68 ec 00 00 00       	push   $0xec
8010682e:	e9 cb f1 ff ff       	jmp    801059fe <alltraps>

80106833 <vector237>:
80106833:	6a 00                	push   $0x0
80106835:	68 ed 00 00 00       	push   $0xed
8010683a:	e9 bf f1 ff ff       	jmp    801059fe <alltraps>

8010683f <vector238>:
8010683f:	6a 00                	push   $0x0
80106841:	68 ee 00 00 00       	push   $0xee
80106846:	e9 b3 f1 ff ff       	jmp    801059fe <alltraps>

8010684b <vector239>:
8010684b:	6a 00                	push   $0x0
8010684d:	68 ef 00 00 00       	push   $0xef
80106852:	e9 a7 f1 ff ff       	jmp    801059fe <alltraps>

80106857 <vector240>:
80106857:	6a 00                	push   $0x0
80106859:	68 f0 00 00 00       	push   $0xf0
8010685e:	e9 9b f1 ff ff       	jmp    801059fe <alltraps>

80106863 <vector241>:
80106863:	6a 00                	push   $0x0
80106865:	68 f1 00 00 00       	push   $0xf1
8010686a:	e9 8f f1 ff ff       	jmp    801059fe <alltraps>

8010686f <vector242>:
8010686f:	6a 00                	push   $0x0
80106871:	68 f2 00 00 00       	push   $0xf2
80106876:	e9 83 f1 ff ff       	jmp    801059fe <alltraps>

8010687b <vector243>:
8010687b:	6a 00                	push   $0x0
8010687d:	68 f3 00 00 00       	push   $0xf3
80106882:	e9 77 f1 ff ff       	jmp    801059fe <alltraps>

80106887 <vector244>:
80106887:	6a 00                	push   $0x0
80106889:	68 f4 00 00 00       	push   $0xf4
8010688e:	e9 6b f1 ff ff       	jmp    801059fe <alltraps>

80106893 <vector245>:
80106893:	6a 00                	push   $0x0
80106895:	68 f5 00 00 00       	push   $0xf5
8010689a:	e9 5f f1 ff ff       	jmp    801059fe <alltraps>

8010689f <vector246>:
8010689f:	6a 00                	push   $0x0
801068a1:	68 f6 00 00 00       	push   $0xf6
801068a6:	e9 53 f1 ff ff       	jmp    801059fe <alltraps>

801068ab <vector247>:
801068ab:	6a 00                	push   $0x0
801068ad:	68 f7 00 00 00       	push   $0xf7
801068b2:	e9 47 f1 ff ff       	jmp    801059fe <alltraps>

801068b7 <vector248>:
801068b7:	6a 00                	push   $0x0
801068b9:	68 f8 00 00 00       	push   $0xf8
801068be:	e9 3b f1 ff ff       	jmp    801059fe <alltraps>

801068c3 <vector249>:
801068c3:	6a 00                	push   $0x0
801068c5:	68 f9 00 00 00       	push   $0xf9
801068ca:	e9 2f f1 ff ff       	jmp    801059fe <alltraps>

801068cf <vector250>:
801068cf:	6a 00                	push   $0x0
801068d1:	68 fa 00 00 00       	push   $0xfa
801068d6:	e9 23 f1 ff ff       	jmp    801059fe <alltraps>

801068db <vector251>:
801068db:	6a 00                	push   $0x0
801068dd:	68 fb 00 00 00       	push   $0xfb
801068e2:	e9 17 f1 ff ff       	jmp    801059fe <alltraps>

801068e7 <vector252>:
801068e7:	6a 00                	push   $0x0
801068e9:	68 fc 00 00 00       	push   $0xfc
801068ee:	e9 0b f1 ff ff       	jmp    801059fe <alltraps>

801068f3 <vector253>:
801068f3:	6a 00                	push   $0x0
801068f5:	68 fd 00 00 00       	push   $0xfd
801068fa:	e9 ff f0 ff ff       	jmp    801059fe <alltraps>

801068ff <vector254>:
801068ff:	6a 00                	push   $0x0
80106901:	68 fe 00 00 00       	push   $0xfe
80106906:	e9 f3 f0 ff ff       	jmp    801059fe <alltraps>

8010690b <vector255>:
8010690b:	6a 00                	push   $0x0
8010690d:	68 ff 00 00 00       	push   $0xff
80106912:	e9 e7 f0 ff ff       	jmp    801059fe <alltraps>
80106917:	66 90                	xchg   %ax,%ax
80106919:	66 90                	xchg   %ax,%ax
8010691b:	66 90                	xchg   %ax,%ax
8010691d:	66 90                	xchg   %ax,%ax
8010691f:	90                   	nop

80106920 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106920:	55                   	push   %ebp
80106921:	89 e5                	mov    %esp,%ebp
80106923:	57                   	push   %edi
80106924:	56                   	push   %esi
80106925:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106926:	89 d3                	mov    %edx,%ebx
{
80106928:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010692a:	c1 eb 16             	shr    $0x16,%ebx
8010692d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106930:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106933:	8b 06                	mov    (%esi),%eax
80106935:	a8 01                	test   $0x1,%al
80106937:	74 27                	je     80106960 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106939:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010693e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106944:	c1 ef 0a             	shr    $0xa,%edi
}
80106947:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010694a:	89 fa                	mov    %edi,%edx
8010694c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106952:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106955:	5b                   	pop    %ebx
80106956:	5e                   	pop    %esi
80106957:	5f                   	pop    %edi
80106958:	5d                   	pop    %ebp
80106959:	c3                   	ret    
8010695a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106960:	85 c9                	test   %ecx,%ecx
80106962:	74 2c                	je     80106990 <walkpgdir+0x70>
80106964:	e8 67 bb ff ff       	call   801024d0 <kalloc>
80106969:	85 c0                	test   %eax,%eax
8010696b:	89 c3                	mov    %eax,%ebx
8010696d:	74 21                	je     80106990 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010696f:	83 ec 04             	sub    $0x4,%esp
80106972:	68 00 10 00 00       	push   $0x1000
80106977:	6a 00                	push   $0x0
80106979:	50                   	push   %eax
8010697a:	e8 f1 dd ff ff       	call   80104770 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010697f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106985:	83 c4 10             	add    $0x10,%esp
80106988:	83 c8 07             	or     $0x7,%eax
8010698b:	89 06                	mov    %eax,(%esi)
8010698d:	eb b5                	jmp    80106944 <walkpgdir+0x24>
8010698f:	90                   	nop
}
80106990:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106993:	31 c0                	xor    %eax,%eax
}
80106995:	5b                   	pop    %ebx
80106996:	5e                   	pop    %esi
80106997:	5f                   	pop    %edi
80106998:	5d                   	pop    %ebp
80106999:	c3                   	ret    
8010699a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801069a0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801069a0:	55                   	push   %ebp
801069a1:	89 e5                	mov    %esp,%ebp
801069a3:	57                   	push   %edi
801069a4:	56                   	push   %esi
801069a5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801069a6:	89 d3                	mov    %edx,%ebx
801069a8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801069ae:	83 ec 1c             	sub    $0x1c,%esp
801069b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801069b4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801069b8:	8b 7d 08             	mov    0x8(%ebp),%edi
801069bb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801069c6:	29 df                	sub    %ebx,%edi
801069c8:	83 c8 01             	or     $0x1,%eax
801069cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801069ce:	eb 15                	jmp    801069e5 <mappages+0x45>
    if(*pte & PTE_P)
801069d0:	f6 00 01             	testb  $0x1,(%eax)
801069d3:	75 45                	jne    80106a1a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801069d5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801069d8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801069db:	89 30                	mov    %esi,(%eax)
    if(a == last)
801069dd:	74 31                	je     80106a10 <mappages+0x70>
      break;
    a += PGSIZE;
801069df:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801069e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069e8:	b9 01 00 00 00       	mov    $0x1,%ecx
801069ed:	89 da                	mov    %ebx,%edx
801069ef:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801069f2:	e8 29 ff ff ff       	call   80106920 <walkpgdir>
801069f7:	85 c0                	test   %eax,%eax
801069f9:	75 d5                	jne    801069d0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801069fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801069fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a03:	5b                   	pop    %ebx
80106a04:	5e                   	pop    %esi
80106a05:	5f                   	pop    %edi
80106a06:	5d                   	pop    %ebp
80106a07:	c3                   	ret    
80106a08:	90                   	nop
80106a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106a13:	31 c0                	xor    %eax,%eax
}
80106a15:	5b                   	pop    %ebx
80106a16:	5e                   	pop    %esi
80106a17:	5f                   	pop    %edi
80106a18:	5d                   	pop    %ebp
80106a19:	c3                   	ret    
      panic("remap");
80106a1a:	83 ec 0c             	sub    $0xc,%esp
80106a1d:	68 30 7b 10 80       	push   $0x80107b30
80106a22:	e8 69 99 ff ff       	call   80100390 <panic>
80106a27:	89 f6                	mov    %esi,%esi
80106a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a30 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	57                   	push   %edi
80106a34:	56                   	push   %esi
80106a35:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a3c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106a3e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a44:	83 ec 1c             	sub    $0x1c,%esp
80106a47:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106a4a:	39 d3                	cmp    %edx,%ebx
80106a4c:	73 60                	jae    80106aae <deallocuvm.part.0+0x7e>
80106a4e:	89 d6                	mov    %edx,%esi
80106a50:	eb 3d                	jmp    80106a8f <deallocuvm.part.0+0x5f>
80106a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a58:	8b 10                	mov    (%eax),%edx
80106a5a:	f6 c2 01             	test   $0x1,%dl
80106a5d:	74 26                	je     80106a85 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a5f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a65:	74 52                	je     80106ab9 <deallocuvm.part.0+0x89>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106a67:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106a6a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106a70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106a73:	52                   	push   %edx
80106a74:	e8 a7 b8 ff ff       	call   80102320 <kfree>
      *pte = 0;
80106a79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a7c:	83 c4 10             	add    $0x10,%esp
80106a7f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106a85:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a8b:	39 f3                	cmp    %esi,%ebx
80106a8d:	73 1f                	jae    80106aae <deallocuvm.part.0+0x7e>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a8f:	31 c9                	xor    %ecx,%ecx
80106a91:	89 da                	mov    %ebx,%edx
80106a93:	89 f8                	mov    %edi,%eax
80106a95:	e8 86 fe ff ff       	call   80106920 <walkpgdir>
    if(!pte)
80106a9a:	85 c0                	test   %eax,%eax
80106a9c:	75 ba                	jne    80106a58 <deallocuvm.part.0+0x28>
      a += (NPTENTRIES - 1) * PGSIZE;
80106a9e:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106aa4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106aaa:	39 f3                	cmp    %esi,%ebx
80106aac:	72 e1                	jb     80106a8f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106aae:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ab1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ab4:	5b                   	pop    %ebx
80106ab5:	5e                   	pop    %esi
80106ab6:	5f                   	pop    %edi
80106ab7:	5d                   	pop    %ebp
80106ab8:	c3                   	ret    
        panic("kfree");
80106ab9:	83 ec 0c             	sub    $0xc,%esp
80106abc:	68 72 74 10 80       	push   $0x80107472
80106ac1:	e8 ca 98 ff ff       	call   80100390 <panic>
80106ac6:	8d 76 00             	lea    0x0(%esi),%esi
80106ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ad0 <seginit>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	53                   	push   %ebx
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106ad4:	31 db                	xor    %ebx,%ebx
{
80106ad6:	83 ec 14             	sub    $0x14,%esp
  c = &cpus[cpunum()];
80106ad9:	e8 62 bc ff ff       	call   80102740 <cpunum>
80106ade:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106ae4:	8d 90 a0 27 11 80    	lea    -0x7feed860(%eax),%edx
80106aea:	8d 88 54 28 11 80    	lea    -0x7feed7ac(%eax),%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106af0:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106af7:	ff 00 00 
80106afa:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106b01:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b04:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106b0b:	ff 00 00 
80106b0e:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106b15:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b18:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106b1f:	ff 00 00 
80106b22:	c7 80 34 28 11 80 00 	movl   $0xcffa00,-0x7feed7cc(%eax)
80106b29:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b2c:	c7 80 38 28 11 80 ff 	movl   $0xffff,-0x7feed7c8(%eax)
80106b33:	ff 00 00 
80106b36:	c7 80 3c 28 11 80 00 	movl   $0xcff200,-0x7feed7c4(%eax)
80106b3d:	f2 cf 00 
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106b40:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106b47:	89 cb                	mov    %ecx,%ebx
80106b49:	c1 eb 10             	shr    $0x10,%ebx
80106b4c:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106b53:	c1 e9 18             	shr    $0x18,%ecx
80106b56:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106b5c:	bb 92 c0 ff ff       	mov    $0xffffc092,%ebx
80106b61:	66 89 98 2d 28 11 80 	mov    %bx,-0x7feed7d3(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106b68:	05 10 28 11 80       	add    $0x80112810,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106b6d:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
  pd[0] = size-1;
80106b73:	b9 37 00 00 00       	mov    $0x37,%ecx
80106b78:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  pd[1] = (uint)p;
80106b7c:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b80:	c1 e8 10             	shr    $0x10,%eax
80106b83:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106b87:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b8a:	0f 01 10             	lgdtl  (%eax)
  asm volatile("movw %0, %%gs" : : "r" (v));
80106b8d:	b8 18 00 00 00       	mov    $0x18,%eax
80106b92:	8e e8                	mov    %eax,%gs
  proc = 0;
80106b94:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106b9b:	00 00 00 00 
  c = &cpus[cpunum()];
80106b9f:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
}
80106ba6:	83 c4 14             	add    $0x14,%esp
80106ba9:	5b                   	pop    %ebx
80106baa:	5d                   	pop    %ebp
80106bab:	c3                   	ret    
80106bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bb0 <setupkvm>:
{
80106bb0:	55                   	push   %ebp
80106bb1:	89 e5                	mov    %esp,%ebp
80106bb3:	56                   	push   %esi
80106bb4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106bb5:	e8 16 b9 ff ff       	call   801024d0 <kalloc>
80106bba:	85 c0                	test   %eax,%eax
80106bbc:	74 52                	je     80106c10 <setupkvm+0x60>
  memset(pgdir, 0, PGSIZE);
80106bbe:	83 ec 04             	sub    $0x4,%esp
80106bc1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106bc3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106bc8:	68 00 10 00 00       	push   $0x1000
80106bcd:	6a 00                	push   $0x0
80106bcf:	50                   	push   %eax
80106bd0:	e8 9b db ff ff       	call   80104770 <memset>
80106bd5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0)
80106bd8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106bdb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106bde:	83 ec 08             	sub    $0x8,%esp
80106be1:	8b 13                	mov    (%ebx),%edx
80106be3:	ff 73 0c             	pushl  0xc(%ebx)
80106be6:	50                   	push   %eax
80106be7:	29 c1                	sub    %eax,%ecx
80106be9:	89 f0                	mov    %esi,%eax
80106beb:	e8 b0 fd ff ff       	call   801069a0 <mappages>
80106bf0:	83 c4 10             	add    $0x10,%esp
80106bf3:	85 c0                	test   %eax,%eax
80106bf5:	78 19                	js     80106c10 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106bf7:	83 c3 10             	add    $0x10,%ebx
80106bfa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106c00:	75 d6                	jne    80106bd8 <setupkvm+0x28>
}
80106c02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106c05:	89 f0                	mov    %esi,%eax
80106c07:	5b                   	pop    %ebx
80106c08:	5e                   	pop    %esi
80106c09:	5d                   	pop    %ebp
80106c0a:	c3                   	ret    
80106c0b:	90                   	nop
80106c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c10:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106c13:	31 f6                	xor    %esi,%esi
}
80106c15:	89 f0                	mov    %esi,%eax
80106c17:	5b                   	pop    %ebx
80106c18:	5e                   	pop    %esi
80106c19:	5d                   	pop    %ebp
80106c1a:	c3                   	ret    
80106c1b:	90                   	nop
80106c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c20 <kvmalloc>:
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106c26:	e8 85 ff ff ff       	call   80106bb0 <setupkvm>
80106c2b:	a3 24 57 11 80       	mov    %eax,0x80115724
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c30:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c35:	0f 22 d8             	mov    %eax,%cr3
}
80106c38:	c9                   	leave  
80106c39:	c3                   	ret    
80106c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c40 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c40:	a1 24 57 11 80       	mov    0x80115724,%eax
{
80106c45:	55                   	push   %ebp
80106c46:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c48:	05 00 00 00 80       	add    $0x80000000,%eax
80106c4d:	0f 22 d8             	mov    %eax,%cr3
}
80106c50:	5d                   	pop    %ebp
80106c51:	c3                   	ret    
80106c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c60 <switchuvm>:
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	53                   	push   %ebx
80106c64:	83 ec 04             	sub    $0x4,%esp
80106c67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80106c6a:	e8 31 da ff ff       	call   801046a0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106c6f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106c75:	b9 67 00 00 00       	mov    $0x67,%ecx
80106c7a:	8d 50 08             	lea    0x8(%eax),%edx
80106c7d:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106c84:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106c8b:	89 d1                	mov    %edx,%ecx
80106c8d:	c1 ea 18             	shr    $0x18,%edx
80106c90:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80106c96:	ba 89 40 00 00       	mov    $0x4089,%edx
80106c9b:	c1 e9 10             	shr    $0x10,%ecx
80106c9e:	66 89 90 a5 00 00 00 	mov    %dx,0xa5(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106ca5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106cac:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80106cb2:	b9 10 00 00 00       	mov    $0x10,%ecx
80106cb7:	66 89 48 10          	mov    %cx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106cbb:	8b 52 08             	mov    0x8(%edx),%edx
80106cbe:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106cc4:	89 50 0c             	mov    %edx,0xc(%eax)
  cpu->ts.iomb = (ushort) 0xFFFF;
80106cc7:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106ccc:	66 89 50 6e          	mov    %dx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106cd0:	b8 30 00 00 00       	mov    $0x30,%eax
80106cd5:	0f 00 d8             	ltr    %ax
  if(p->pgdir == 0)
80106cd8:	8b 43 04             	mov    0x4(%ebx),%eax
80106cdb:	85 c0                	test   %eax,%eax
80106cdd:	74 11                	je     80106cf0 <switchuvm+0x90>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106cdf:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ce4:	0f 22 d8             	mov    %eax,%cr3
}
80106ce7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106cea:	c9                   	leave  
  popcli();
80106ceb:	e9 e0 d9 ff ff       	jmp    801046d0 <popcli>
    panic("switchuvm: no pgdir");
80106cf0:	83 ec 0c             	sub    $0xc,%esp
80106cf3:	68 36 7b 10 80       	push   $0x80107b36
80106cf8:	e8 93 96 ff ff       	call   80100390 <panic>
80106cfd:	8d 76 00             	lea    0x0(%esi),%esi

80106d00 <inituvm>:
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	57                   	push   %edi
80106d04:	56                   	push   %esi
80106d05:	53                   	push   %ebx
80106d06:	83 ec 1c             	sub    $0x1c,%esp
80106d09:	8b 75 10             	mov    0x10(%ebp),%esi
80106d0c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d0f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106d12:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106d18:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106d1b:	77 49                	ja     80106d66 <inituvm+0x66>
  mem = kalloc();
80106d1d:	e8 ae b7 ff ff       	call   801024d0 <kalloc>
  memset(mem, 0, PGSIZE);
80106d22:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106d25:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106d27:	68 00 10 00 00       	push   $0x1000
80106d2c:	6a 00                	push   $0x0
80106d2e:	50                   	push   %eax
80106d2f:	e8 3c da ff ff       	call   80104770 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106d34:	58                   	pop    %eax
80106d35:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d3b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d40:	5a                   	pop    %edx
80106d41:	6a 06                	push   $0x6
80106d43:	50                   	push   %eax
80106d44:	31 d2                	xor    %edx,%edx
80106d46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d49:	e8 52 fc ff ff       	call   801069a0 <mappages>
  memmove(mem, init, sz);
80106d4e:	89 75 10             	mov    %esi,0x10(%ebp)
80106d51:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106d54:	83 c4 10             	add    $0x10,%esp
80106d57:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106d5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d5d:	5b                   	pop    %ebx
80106d5e:	5e                   	pop    %esi
80106d5f:	5f                   	pop    %edi
80106d60:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106d61:	e9 ba da ff ff       	jmp    80104820 <memmove>
    panic("inituvm: more than a page");
80106d66:	83 ec 0c             	sub    $0xc,%esp
80106d69:	68 4a 7b 10 80       	push   $0x80107b4a
80106d6e:	e8 1d 96 ff ff       	call   80100390 <panic>
80106d73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d80 <loaduvm>:
{
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	57                   	push   %edi
80106d84:	56                   	push   %esi
80106d85:	53                   	push   %ebx
80106d86:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106d89:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106d90:	0f 85 91 00 00 00    	jne    80106e27 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106d96:	8b 75 18             	mov    0x18(%ebp),%esi
80106d99:	31 db                	xor    %ebx,%ebx
80106d9b:	85 f6                	test   %esi,%esi
80106d9d:	75 1a                	jne    80106db9 <loaduvm+0x39>
80106d9f:	eb 6f                	jmp    80106e10 <loaduvm+0x90>
80106da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106da8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106dae:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106db4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106db7:	76 57                	jbe    80106e10 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106db9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106dbc:	8b 45 08             	mov    0x8(%ebp),%eax
80106dbf:	31 c9                	xor    %ecx,%ecx
80106dc1:	01 da                	add    %ebx,%edx
80106dc3:	e8 58 fb ff ff       	call   80106920 <walkpgdir>
80106dc8:	85 c0                	test   %eax,%eax
80106dca:	74 4e                	je     80106e1a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106dcc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106dce:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106dd1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106dd6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106ddb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106de1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106de4:	01 d9                	add    %ebx,%ecx
80106de6:	05 00 00 00 80       	add    $0x80000000,%eax
80106deb:	57                   	push   %edi
80106dec:	51                   	push   %ecx
80106ded:	50                   	push   %eax
80106dee:	ff 75 10             	pushl  0x10(%ebp)
80106df1:	e8 4a ab ff ff       	call   80101940 <readi>
80106df6:	83 c4 10             	add    $0x10,%esp
80106df9:	39 f8                	cmp    %edi,%eax
80106dfb:	74 ab                	je     80106da8 <loaduvm+0x28>
}
80106dfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e05:	5b                   	pop    %ebx
80106e06:	5e                   	pop    %esi
80106e07:	5f                   	pop    %edi
80106e08:	5d                   	pop    %ebp
80106e09:	c3                   	ret    
80106e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e13:	31 c0                	xor    %eax,%eax
}
80106e15:	5b                   	pop    %ebx
80106e16:	5e                   	pop    %esi
80106e17:	5f                   	pop    %edi
80106e18:	5d                   	pop    %ebp
80106e19:	c3                   	ret    
      panic("loaduvm: address should exist");
80106e1a:	83 ec 0c             	sub    $0xc,%esp
80106e1d:	68 64 7b 10 80       	push   $0x80107b64
80106e22:	e8 69 95 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106e27:	83 ec 0c             	sub    $0xc,%esp
80106e2a:	68 08 7c 10 80       	push   $0x80107c08
80106e2f:	e8 5c 95 ff ff       	call   80100390 <panic>
80106e34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e40 <allocuvm>:
{
80106e40:	55                   	push   %ebp
80106e41:	89 e5                	mov    %esp,%ebp
80106e43:	57                   	push   %edi
80106e44:	56                   	push   %esi
80106e45:	53                   	push   %ebx
80106e46:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106e49:	8b 7d 10             	mov    0x10(%ebp),%edi
80106e4c:	85 ff                	test   %edi,%edi
80106e4e:	0f 88 8e 00 00 00    	js     80106ee2 <allocuvm+0xa2>
  if(newsz < oldsz)
80106e54:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e57:	0f 82 93 00 00 00    	jb     80106ef0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e60:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106e66:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106e6c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106e6f:	0f 86 7e 00 00 00    	jbe    80106ef3 <allocuvm+0xb3>
80106e75:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106e78:	8b 7d 08             	mov    0x8(%ebp),%edi
80106e7b:	eb 42                	jmp    80106ebf <allocuvm+0x7f>
80106e7d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106e80:	83 ec 04             	sub    $0x4,%esp
80106e83:	68 00 10 00 00       	push   $0x1000
80106e88:	6a 00                	push   $0x0
80106e8a:	50                   	push   %eax
80106e8b:	e8 e0 d8 ff ff       	call   80104770 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e90:	58                   	pop    %eax
80106e91:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e97:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e9c:	5a                   	pop    %edx
80106e9d:	6a 06                	push   $0x6
80106e9f:	50                   	push   %eax
80106ea0:	89 da                	mov    %ebx,%edx
80106ea2:	89 f8                	mov    %edi,%eax
80106ea4:	e8 f7 fa ff ff       	call   801069a0 <mappages>
80106ea9:	83 c4 10             	add    $0x10,%esp
80106eac:	85 c0                	test   %eax,%eax
80106eae:	78 50                	js     80106f00 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106eb0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106eb6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106eb9:	0f 86 81 00 00 00    	jbe    80106f40 <allocuvm+0x100>
    mem = kalloc();
80106ebf:	e8 0c b6 ff ff       	call   801024d0 <kalloc>
    if(mem == 0){
80106ec4:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106ec6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106ec8:	75 b6                	jne    80106e80 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106eca:	83 ec 0c             	sub    $0xc,%esp
80106ecd:	68 82 7b 10 80       	push   $0x80107b82
80106ed2:	e8 89 97 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106ed7:	83 c4 10             	add    $0x10,%esp
80106eda:	8b 45 0c             	mov    0xc(%ebp),%eax
80106edd:	39 45 10             	cmp    %eax,0x10(%ebp)
80106ee0:	77 6e                	ja     80106f50 <allocuvm+0x110>
}
80106ee2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106ee5:	31 ff                	xor    %edi,%edi
}
80106ee7:	89 f8                	mov    %edi,%eax
80106ee9:	5b                   	pop    %ebx
80106eea:	5e                   	pop    %esi
80106eeb:	5f                   	pop    %edi
80106eec:	5d                   	pop    %ebp
80106eed:	c3                   	ret    
80106eee:	66 90                	xchg   %ax,%ax
    return oldsz;
80106ef0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ef6:	89 f8                	mov    %edi,%eax
80106ef8:	5b                   	pop    %ebx
80106ef9:	5e                   	pop    %esi
80106efa:	5f                   	pop    %edi
80106efb:	5d                   	pop    %ebp
80106efc:	c3                   	ret    
80106efd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106f00:	83 ec 0c             	sub    $0xc,%esp
80106f03:	68 9a 7b 10 80       	push   $0x80107b9a
80106f08:	e8 53 97 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106f0d:	83 c4 10             	add    $0x10,%esp
80106f10:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f13:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f16:	76 0d                	jbe    80106f25 <allocuvm+0xe5>
80106f18:	89 c1                	mov    %eax,%ecx
80106f1a:	8b 55 10             	mov    0x10(%ebp),%edx
80106f1d:	8b 45 08             	mov    0x8(%ebp),%eax
80106f20:	e8 0b fb ff ff       	call   80106a30 <deallocuvm.part.0>
      kfree(mem);
80106f25:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106f28:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106f2a:	56                   	push   %esi
80106f2b:	e8 f0 b3 ff ff       	call   80102320 <kfree>
      return 0;
80106f30:	83 c4 10             	add    $0x10,%esp
}
80106f33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f36:	89 f8                	mov    %edi,%eax
80106f38:	5b                   	pop    %ebx
80106f39:	5e                   	pop    %esi
80106f3a:	5f                   	pop    %edi
80106f3b:	5d                   	pop    %ebp
80106f3c:	c3                   	ret    
80106f3d:	8d 76 00             	lea    0x0(%esi),%esi
80106f40:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106f43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f46:	5b                   	pop    %ebx
80106f47:	89 f8                	mov    %edi,%eax
80106f49:	5e                   	pop    %esi
80106f4a:	5f                   	pop    %edi
80106f4b:	5d                   	pop    %ebp
80106f4c:	c3                   	ret    
80106f4d:	8d 76 00             	lea    0x0(%esi),%esi
80106f50:	89 c1                	mov    %eax,%ecx
80106f52:	8b 55 10             	mov    0x10(%ebp),%edx
80106f55:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106f58:	31 ff                	xor    %edi,%edi
80106f5a:	e8 d1 fa ff ff       	call   80106a30 <deallocuvm.part.0>
80106f5f:	eb 92                	jmp    80106ef3 <allocuvm+0xb3>
80106f61:	eb 0d                	jmp    80106f70 <deallocuvm>
80106f63:	90                   	nop
80106f64:	90                   	nop
80106f65:	90                   	nop
80106f66:	90                   	nop
80106f67:	90                   	nop
80106f68:	90                   	nop
80106f69:	90                   	nop
80106f6a:	90                   	nop
80106f6b:	90                   	nop
80106f6c:	90                   	nop
80106f6d:	90                   	nop
80106f6e:	90                   	nop
80106f6f:	90                   	nop

80106f70 <deallocuvm>:
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f76:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106f79:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106f7c:	39 d1                	cmp    %edx,%ecx
80106f7e:	73 10                	jae    80106f90 <deallocuvm+0x20>
}
80106f80:	5d                   	pop    %ebp
80106f81:	e9 aa fa ff ff       	jmp    80106a30 <deallocuvm.part.0>
80106f86:	8d 76 00             	lea    0x0(%esi),%esi
80106f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106f90:	89 d0                	mov    %edx,%eax
80106f92:	5d                   	pop    %ebp
80106f93:	c3                   	ret    
80106f94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106fa0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106fa0:	55                   	push   %ebp
80106fa1:	89 e5                	mov    %esp,%ebp
80106fa3:	57                   	push   %edi
80106fa4:	56                   	push   %esi
80106fa5:	53                   	push   %ebx
80106fa6:	83 ec 0c             	sub    $0xc,%esp
80106fa9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106fac:	85 f6                	test   %esi,%esi
80106fae:	74 59                	je     80107009 <freevm+0x69>
80106fb0:	31 c9                	xor    %ecx,%ecx
80106fb2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106fb7:	89 f0                	mov    %esi,%eax
80106fb9:	e8 72 fa ff ff       	call   80106a30 <deallocuvm.part.0>
80106fbe:	89 f3                	mov    %esi,%ebx
80106fc0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106fc6:	eb 0f                	jmp    80106fd7 <freevm+0x37>
80106fc8:	90                   	nop
80106fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fd0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106fd3:	39 fb                	cmp    %edi,%ebx
80106fd5:	74 23                	je     80106ffa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106fd7:	8b 03                	mov    (%ebx),%eax
80106fd9:	a8 01                	test   $0x1,%al
80106fdb:	74 f3                	je     80106fd0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106fdd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106fe2:	83 ec 0c             	sub    $0xc,%esp
80106fe5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106fe8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106fed:	50                   	push   %eax
80106fee:	e8 2d b3 ff ff       	call   80102320 <kfree>
80106ff3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106ff6:	39 fb                	cmp    %edi,%ebx
80106ff8:	75 dd                	jne    80106fd7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106ffa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106ffd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107000:	5b                   	pop    %ebx
80107001:	5e                   	pop    %esi
80107002:	5f                   	pop    %edi
80107003:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107004:	e9 17 b3 ff ff       	jmp    80102320 <kfree>
    panic("freevm: no pgdir");
80107009:	83 ec 0c             	sub    $0xc,%esp
8010700c:	68 b6 7b 10 80       	push   $0x80107bb6
80107011:	e8 7a 93 ff ff       	call   80100390 <panic>
80107016:	8d 76 00             	lea    0x0(%esi),%esi
80107019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107020 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107020:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107021:	31 c9                	xor    %ecx,%ecx
{
80107023:	89 e5                	mov    %esp,%ebp
80107025:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107028:	8b 55 0c             	mov    0xc(%ebp),%edx
8010702b:	8b 45 08             	mov    0x8(%ebp),%eax
8010702e:	e8 ed f8 ff ff       	call   80106920 <walkpgdir>
  if(pte == 0)
80107033:	85 c0                	test   %eax,%eax
80107035:	74 05                	je     8010703c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107037:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010703a:	c9                   	leave  
8010703b:	c3                   	ret    
    panic("clearpteu");
8010703c:	83 ec 0c             	sub    $0xc,%esp
8010703f:	68 c7 7b 10 80       	push   $0x80107bc7
80107044:	e8 47 93 ff ff       	call   80100390 <panic>
80107049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107050 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	57                   	push   %edi
80107054:	56                   	push   %esi
80107055:	53                   	push   %ebx
80107056:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107059:	e8 52 fb ff ff       	call   80106bb0 <setupkvm>
8010705e:	85 c0                	test   %eax,%eax
80107060:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107063:	0f 84 a0 00 00 00    	je     80107109 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107069:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010706c:	85 c9                	test   %ecx,%ecx
8010706e:	0f 84 95 00 00 00    	je     80107109 <copyuvm+0xb9>
80107074:	31 f6                	xor    %esi,%esi
80107076:	eb 4e                	jmp    801070c6 <copyuvm+0x76>
80107078:	90                   	nop
80107079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107080:	83 ec 04             	sub    $0x4,%esp
80107083:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107089:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010708c:	68 00 10 00 00       	push   $0x1000
80107091:	57                   	push   %edi
80107092:	50                   	push   %eax
80107093:	e8 88 d7 ff ff       	call   80104820 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107098:	58                   	pop    %eax
80107099:	5a                   	pop    %edx
8010709a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010709d:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070a0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070a5:	53                   	push   %ebx
801070a6:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801070ac:	52                   	push   %edx
801070ad:	89 f2                	mov    %esi,%edx
801070af:	e8 ec f8 ff ff       	call   801069a0 <mappages>
801070b4:	83 c4 10             	add    $0x10,%esp
801070b7:	85 c0                	test   %eax,%eax
801070b9:	78 39                	js     801070f4 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
801070bb:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070c1:	39 75 0c             	cmp    %esi,0xc(%ebp)
801070c4:	76 43                	jbe    80107109 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801070c6:	8b 45 08             	mov    0x8(%ebp),%eax
801070c9:	31 c9                	xor    %ecx,%ecx
801070cb:	89 f2                	mov    %esi,%edx
801070cd:	e8 4e f8 ff ff       	call   80106920 <walkpgdir>
801070d2:	85 c0                	test   %eax,%eax
801070d4:	74 3e                	je     80107114 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
801070d6:	8b 18                	mov    (%eax),%ebx
801070d8:	f6 c3 01             	test   $0x1,%bl
801070db:	74 44                	je     80107121 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
801070dd:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801070df:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801070e5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801070eb:	e8 e0 b3 ff ff       	call   801024d0 <kalloc>
801070f0:	85 c0                	test   %eax,%eax
801070f2:	75 8c                	jne    80107080 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801070f4:	83 ec 0c             	sub    $0xc,%esp
801070f7:	ff 75 e0             	pushl  -0x20(%ebp)
801070fa:	e8 a1 fe ff ff       	call   80106fa0 <freevm>
  return 0;
801070ff:	83 c4 10             	add    $0x10,%esp
80107102:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107109:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010710c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010710f:	5b                   	pop    %ebx
80107110:	5e                   	pop    %esi
80107111:	5f                   	pop    %edi
80107112:	5d                   	pop    %ebp
80107113:	c3                   	ret    
      panic("copyuvm: pte should exist");
80107114:	83 ec 0c             	sub    $0xc,%esp
80107117:	68 d1 7b 10 80       	push   $0x80107bd1
8010711c:	e8 6f 92 ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
80107121:	83 ec 0c             	sub    $0xc,%esp
80107124:	68 eb 7b 10 80       	push   $0x80107beb
80107129:	e8 62 92 ff ff       	call   80100390 <panic>
8010712e:	66 90                	xchg   %ax,%ax

80107130 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107130:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107131:	31 c9                	xor    %ecx,%ecx
{
80107133:	89 e5                	mov    %esp,%ebp
80107135:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107138:	8b 55 0c             	mov    0xc(%ebp),%edx
8010713b:	8b 45 08             	mov    0x8(%ebp),%eax
8010713e:	e8 dd f7 ff ff       	call   80106920 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107143:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107145:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107146:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107148:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010714d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107150:	05 00 00 00 80       	add    $0x80000000,%eax
80107155:	83 fa 05             	cmp    $0x5,%edx
80107158:	ba 00 00 00 00       	mov    $0x0,%edx
8010715d:	0f 45 c2             	cmovne %edx,%eax
}
80107160:	c3                   	ret    
80107161:	eb 0d                	jmp    80107170 <copyout>
80107163:	90                   	nop
80107164:	90                   	nop
80107165:	90                   	nop
80107166:	90                   	nop
80107167:	90                   	nop
80107168:	90                   	nop
80107169:	90                   	nop
8010716a:	90                   	nop
8010716b:	90                   	nop
8010716c:	90                   	nop
8010716d:	90                   	nop
8010716e:	90                   	nop
8010716f:	90                   	nop

80107170 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 1c             	sub    $0x1c,%esp
80107179:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010717c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010717f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107182:	85 db                	test   %ebx,%ebx
80107184:	75 40                	jne    801071c6 <copyout+0x56>
80107186:	eb 70                	jmp    801071f8 <copyout+0x88>
80107188:	90                   	nop
80107189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107190:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107193:	89 f1                	mov    %esi,%ecx
80107195:	29 d1                	sub    %edx,%ecx
80107197:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010719d:	39 d9                	cmp    %ebx,%ecx
8010719f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801071a2:	29 f2                	sub    %esi,%edx
801071a4:	83 ec 04             	sub    $0x4,%esp
801071a7:	01 d0                	add    %edx,%eax
801071a9:	51                   	push   %ecx
801071aa:	57                   	push   %edi
801071ab:	50                   	push   %eax
801071ac:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801071af:	e8 6c d6 ff ff       	call   80104820 <memmove>
    len -= n;
    buf += n;
801071b4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801071b7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801071ba:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801071c0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801071c2:	29 cb                	sub    %ecx,%ebx
801071c4:	74 32                	je     801071f8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801071c6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071c8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801071cb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801071ce:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071d4:	56                   	push   %esi
801071d5:	ff 75 08             	pushl  0x8(%ebp)
801071d8:	e8 53 ff ff ff       	call   80107130 <uva2ka>
    if(pa0 == 0)
801071dd:	83 c4 10             	add    $0x10,%esp
801071e0:	85 c0                	test   %eax,%eax
801071e2:	75 ac                	jne    80107190 <copyout+0x20>
  }
  return 0;
}
801071e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801071e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801071ec:	5b                   	pop    %ebx
801071ed:	5e                   	pop    %esi
801071ee:	5f                   	pop    %edi
801071ef:	5d                   	pop    %ebp
801071f0:	c3                   	ret    
801071f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801071fb:	31 c0                	xor    %eax,%eax
}
801071fd:	5b                   	pop    %ebx
801071fe:	5e                   	pop    %esi
801071ff:	5f                   	pop    %edi
80107200:	5d                   	pop    %ebp
80107201:	c3                   	ret    
