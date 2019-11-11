
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
8010004c:	68 80 71 10 80       	push   $0x80107180
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 45 44 00 00       	call   801044a0 <initlock>
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
80100092:	68 87 71 10 80       	push   $0x80107187
80100097:	50                   	push   %eax
80100098:	e8 f3 42 00 00       	call   80104390 <initsleeplock>
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
801000e4:	e8 d7 43 00 00       	call   801044c0 <acquire>
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
80100162:	e8 19 45 00 00       	call   80104680 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 42 00 00       	call   801043d0 <acquiresleep>
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
80100193:	68 8e 71 10 80       	push   $0x8010718e
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
801001ae:	e8 bd 42 00 00       	call   80104470 <holdingsleep>
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
801001cc:	68 9f 71 10 80       	push   $0x8010719f
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
801001ef:	e8 7c 42 00 00       	call   80104470 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 42 00 00       	call   80104430 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 b0 42 00 00       	call   801044c0 <acquire>
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
8010025c:	e9 1f 44 00 00       	jmp    80104680 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 71 10 80       	push   $0x801071a6
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
8010028c:	e8 2f 42 00 00       	call   801044c0 <acquire>
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
801002c5:	e8 e6 3b 00 00       	call   80103eb0 <sleep>
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
801002f0:	e8 8b 43 00 00       	call   80104680 <release>
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
8010034d:	e8 2e 43 00 00       	call   80104680 <release>
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
801003b3:	68 ad 71 10 80       	push   $0x801071ad
801003b8:	e8 a3 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bd:	58                   	pop    %eax
801003be:	ff 75 08             	pushl  0x8(%ebp)
801003c1:	e8 9a 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c6:	c7 04 24 a6 76 10 80 	movl   $0x801076a6,(%esp)
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d2:	5a                   	pop    %edx
801003d3:	8d 45 08             	lea    0x8(%ebp),%eax
801003d6:	59                   	pop    %ecx
801003d7:	53                   	push   %ebx
801003d8:	50                   	push   %eax
801003d9:	e8 a2 41 00 00       	call   80104580 <getcallerpcs>
801003de:	83 c4 10             	add    $0x10,%esp
801003e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003e8:	83 ec 08             	sub    $0x8,%esp
801003eb:	ff 33                	pushl  (%ebx)
801003ed:	83 c3 04             	add    $0x4,%ebx
801003f0:	68 c9 71 10 80       	push   $0x801071c9
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
8010043a:	e8 81 59 00 00       	call   80105dc0 <uartputc>
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
801004ec:	e8 cf 58 00 00       	call   80105dc0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 c3 58 00 00       	call   80105dc0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 b7 58 00 00       	call   80105dc0 <uartputc>
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
80100524:	e8 57 42 00 00       	call   80104780 <memmove>
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
80100541:	e8 8a 41 00 00       	call   801046d0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 cd 71 10 80       	push   $0x801071cd
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
801005b1:	0f b6 92 f8 71 10 80 	movzbl -0x7fef8e08(%edx),%edx
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
8010061b:	e8 a0 3e 00 00       	call   801044c0 <acquire>
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
80100647:	e8 34 40 00 00       	call   80104680 <release>
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
8010071f:	e8 5c 3f 00 00       	call   80104680 <release>
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
801007d0:	ba e0 71 10 80       	mov    $0x801071e0,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 cb 3c 00 00       	call   801044c0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 e7 71 10 80       	push   $0x801071e7
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
80100823:	e8 98 3c 00 00       	call   801044c0 <acquire>
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
80100888:	e8 f3 3d 00 00       	call   80104680 <release>
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
80100916:	e8 35 37 00 00       	call   80104050 <wakeup>
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
80100997:	e9 94 37 00 00       	jmp    80104130 <procdump>
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
801009c6:	68 f0 71 10 80       	push   $0x801071f0
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 cb 3a 00 00       	call   801044a0 <initlock>

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
80100a8c:	e8 7f 60 00 00       	call   80106b10 <setupkvm>
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
80100aee:	e8 ad 62 00 00       	call   80106da0 <allocuvm>
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
80100b20:	e8 bb 61 00 00       	call   80106ce0 <loaduvm>
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
80100b6a:	e8 91 63 00 00       	call   80106f00 <freevm>
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
80100bab:	e8 f0 61 00 00       	call   80106da0 <allocuvm>
80100bb0:	83 c4 10             	add    $0x10,%esp
80100bb3:	85 c0                	test   %eax,%eax
80100bb5:	89 c6                	mov    %eax,%esi
80100bb7:	75 2a                	jne    80100be3 <exec+0x1d3>
    freevm(pgdir);
80100bb9:	83 ec 0c             	sub    $0xc,%esp
80100bbc:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bc2:	e8 39 63 00 00       	call   80106f00 <freevm>
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
80100bf7:	e8 84 63 00 00       	call   80106f80 <clearpteu>
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
80100c29:	e8 e2 3c 00 00       	call   80104910 <strlen>
80100c2e:	f7 d0                	not    %eax
80100c30:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c32:	58                   	pop    %eax
80100c33:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c36:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c39:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c3c:	e8 cf 3c 00 00       	call   80104910 <strlen>
80100c41:	83 c0 01             	add    $0x1,%eax
80100c44:	50                   	push   %eax
80100c45:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c48:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4b:	53                   	push   %ebx
80100c4c:	56                   	push   %esi
80100c4d:	e8 7e 64 00 00       	call   801070d0 <copyout>
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
80100cb7:	e8 14 64 00 00       	call   801070d0 <copyout>
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
80100cf5:	e8 d6 3b 00 00       	call   801048d0 <safestrcpy>
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
80100d29:	e8 92 5e 00 00       	call   80106bc0 <switchuvm>
  freevm(oldpgdir);
80100d2e:	89 3c 24             	mov    %edi,(%esp)
80100d31:	e8 ca 61 00 00       	call   80106f00 <freevm>
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
80100d56:	68 09 72 10 80       	push   $0x80107209
80100d5b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d60:	e8 3b 37 00 00       	call   801044a0 <initlock>
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
80100d81:	e8 3a 37 00 00       	call   801044c0 <acquire>
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
80100db1:	e8 ca 38 00 00       	call   80104680 <release>
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
80100dca:	e8 b1 38 00 00       	call   80104680 <release>
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
80100def:	e8 cc 36 00 00       	call   801044c0 <acquire>
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
80100e0c:	e8 6f 38 00 00       	call   80104680 <release>
  return f;
}
80100e11:	89 d8                	mov    %ebx,%eax
80100e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    
    panic("filedup");
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	68 10 72 10 80       	push   $0x80107210
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
80100e41:	e8 7a 36 00 00       	call   801044c0 <acquire>
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
80100e6c:	e9 0f 38 00 00       	jmp    80104680 <release>
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
80100e98:	e8 e3 37 00 00       	call   80104680 <release>
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
80100ef2:	68 18 72 10 80       	push   $0x80107218
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
80100fd2:	68 22 72 10 80       	push   $0x80107222
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
801010e5:	68 2b 72 10 80       	push   $0x8010722b
801010ea:	e8 a1 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	68 31 72 10 80       	push   $0x80107231
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
801011a4:	68 3b 72 10 80       	push   $0x8010723b
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
801011e5:	e8 e6 34 00 00       	call   801046d0 <memset>
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
8010122a:	e8 91 32 00 00       	call   801044c0 <acquire>
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
8010128f:	e8 ec 33 00 00       	call   80104680 <release>

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
801012bd:	e8 be 33 00 00       	call   80104680 <release>
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
801012d2:	68 51 72 10 80       	push   $0x80107251
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
801013a7:	68 61 72 10 80       	push   $0x80107261
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
801013e1:	e8 9a 33 00 00       	call   80104780 <memmove>
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
80101474:	68 74 72 10 80       	push   $0x80107274
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
8010148c:	68 87 72 10 80       	push   $0x80107287
80101491:	68 00 0a 11 80       	push   $0x80110a00
80101496:	e8 05 30 00 00       	call   801044a0 <initlock>
8010149b:	83 c4 10             	add    $0x10,%esp
8010149e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014a0:	83 ec 08             	sub    $0x8,%esp
801014a3:	68 8e 72 10 80       	push   $0x8010728e
801014a8:	53                   	push   %ebx
801014a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014af:	e8 dc 2e 00 00       	call   80104390 <initsleeplock>
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
801014f9:	68 e4 72 10 80       	push   $0x801072e4
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
8010158e:	e8 3d 31 00 00       	call   801046d0 <memset>
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
801015c3:	68 94 72 10 80       	push   $0x80107294
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
80101631:	e8 4a 31 00 00       	call   80104780 <memmove>
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
8010165f:	e8 5c 2e 00 00       	call   801044c0 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010166f:	e8 0c 30 00 00       	call   80104680 <release>
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
801016a2:	e8 29 2d 00 00       	call   801043d0 <acquiresleep>
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
80101718:	e8 63 30 00 00       	call   80104780 <memmove>
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
8010173a:	68 ac 72 10 80       	push   $0x801072ac
8010173f:	e8 4c ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101744:	83 ec 0c             	sub    $0xc,%esp
80101747:	68 a6 72 10 80       	push   $0x801072a6
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
80101773:	e8 f8 2c 00 00       	call   80104470 <holdingsleep>
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
8010178f:	e9 9c 2c 00 00       	jmp    80104430 <releasesleep>
    panic("iunlock");
80101794:	83 ec 0c             	sub    $0xc,%esp
80101797:	68 bb 72 10 80       	push   $0x801072bb
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
801017c1:	e8 fa 2c 00 00       	call   801044c0 <acquire>
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
801017e5:	e9 96 2e 00 00       	jmp    80104680 <release>
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
8010180e:	e8 6d 2e 00 00       	call   80104680 <release>
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
8010186f:	e8 4c 2c 00 00       	call   801044c0 <acquire>
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
801019e7:	e8 94 2d 00 00       	call   80104780 <memmove>
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
80101ae3:	e8 98 2c 00 00       	call   80104780 <memmove>
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
80101b7e:	e8 7d 2c 00 00       	call   80104800 <strncmp>
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
80101bdd:	e8 1e 2c 00 00       	call   80104800 <strncmp>
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
80101c22:	68 d5 72 10 80       	push   $0x801072d5
80101c27:	e8 64 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c2c:	83 ec 0c             	sub    $0xc,%esp
80101c2f:	68 c3 72 10 80       	push   $0x801072c3
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
80101c6a:	e8 51 28 00 00       	call   801044c0 <acquire>
  ip->ref++;
80101c6f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c73:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c7a:	e8 01 2a 00 00       	call   80104680 <release>
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
80101cd5:	e8 a6 2a 00 00       	call   80104780 <memmove>
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
80101d68:	e8 13 2a 00 00       	call   80104780 <memmove>
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
80101e5d:	e8 0e 2a 00 00       	call   80104870 <strncpy>
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
80101e9b:	68 d5 72 10 80       	push   $0x801072d5
80101ea0:	e8 eb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 26 79 10 80       	push   $0x80107926
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
80101fbb:	68 40 73 10 80       	push   $0x80107340
80101fc0:	e8 cb e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101fc5:	83 ec 0c             	sub    $0xc,%esp
80101fc8:	68 37 73 10 80       	push   $0x80107337
80101fcd:	e8 be e3 ff ff       	call   80100390 <panic>
80101fd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fe0 <ideinit>:
{
80101fe0:	55                   	push   %ebp
80101fe1:	89 e5                	mov    %esp,%ebp
80101fe3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101fe6:	68 52 73 10 80       	push   $0x80107352
80101feb:	68 80 a5 10 80       	push   $0x8010a580
80101ff0:	e8 ab 24 00 00       	call   801044a0 <initlock>
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
8010207e:	e8 3d 24 00 00       	call   801044c0 <acquire>
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
801020e1:	e8 6a 1f 00 00       	call   80104050 <wakeup>

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
801020ff:	e8 7c 25 00 00       	call   80104680 <release>

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
8010211e:	e8 4d 23 00 00       	call   80104470 <holdingsleep>
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
80102158:	e8 63 23 00 00       	call   801044c0 <acquire>

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
801021a9:	e8 02 1d 00 00       	call   80103eb0 <sleep>
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
801021c6:	e9 b5 24 00 00       	jmp    80104680 <release>
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
801021ea:	68 6c 73 10 80       	push   $0x8010736c
801021ef:	e8 9c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801021f4:	83 ec 0c             	sub    $0xc,%esp
801021f7:	68 56 73 10 80       	push   $0x80107356
801021fc:	e8 8f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102201:	83 ec 0c             	sub    $0xc,%esp
80102204:	68 81 73 10 80       	push   $0x80107381
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
801022b3:	68 a0 73 10 80       	push   $0x801073a0
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
80102332:	81 fb 28 56 11 80    	cmp    $0x80115628,%ebx
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
80102352:	e8 79 23 00 00       	call   801046d0 <memset>

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
8010238b:	e9 f0 22 00 00       	jmp    80104680 <release>
    acquire(&kmem.lock);
80102390:	83 ec 0c             	sub    $0xc,%esp
80102393:	68 60 26 11 80       	push   $0x80112660
80102398:	e8 23 21 00 00       	call   801044c0 <acquire>
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	eb c2                	jmp    80102364 <kfree+0x44>
    panic("kfree");
801023a2:	83 ec 0c             	sub    $0xc,%esp
801023a5:	68 d2 73 10 80       	push   $0x801073d2
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
8010240b:	68 d8 73 10 80       	push   $0x801073d8
80102410:	68 60 26 11 80       	push   $0x80112660
80102415:	e8 86 20 00 00       	call   801044a0 <initlock>
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
80102503:	e8 b8 1f 00 00       	call   801044c0 <acquire>
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
80102531:	e8 4a 21 00 00       	call   80104680 <release>
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
80102583:	0f b6 82 00 75 10 80 	movzbl -0x7fef8b00(%edx),%eax
8010258a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010258c:	0f b6 82 00 74 10 80 	movzbl -0x7fef8c00(%edx),%eax
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
801025a3:	8b 04 85 e0 73 10 80 	mov    -0x7fef8c20(,%eax,4),%eax
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
801025c8:	0f b6 82 00 75 10 80 	movzbl -0x7fef8b00(%edx),%eax
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
801027c6:	68 00 76 10 80       	push   $0x80107600
801027cb:	e8 90 de ff ff       	call   80100660 <cprintf>
801027d0:	83 c4 10             	add    $0x10,%esp
801027d3:	eb 89                	jmp    8010275e <cpunum+0x1e>
  panic("unknown apicid\n");
801027d5:	83 ec 0c             	sub    $0xc,%esp
801027d8:	68 2c 76 10 80       	push   $0x8010762c
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
801029d7:	e8 44 1d 00 00       	call   80104720 <memcmp>
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
80102b04:	e8 77 1c 00 00       	call   80104780 <memmove>
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
80102baa:	68 3c 76 10 80       	push   $0x8010763c
80102baf:	68 a0 26 11 80       	push   $0x801126a0
80102bb4:	e8 e7 18 00 00       	call   801044a0 <initlock>
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
80102c4b:	e8 70 18 00 00       	call   801044c0 <acquire>
80102c50:	83 c4 10             	add    $0x10,%esp
80102c53:	eb 18                	jmp    80102c6d <begin_op+0x2d>
80102c55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c58:	83 ec 08             	sub    $0x8,%esp
80102c5b:	68 a0 26 11 80       	push   $0x801126a0
80102c60:	68 a0 26 11 80       	push   $0x801126a0
80102c65:	e8 46 12 00 00       	call   80103eb0 <sleep>
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
80102c9c:	e8 df 19 00 00       	call   80104680 <release>
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
80102cbe:	e8 fd 17 00 00       	call   801044c0 <acquire>
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
80102cfc:	e8 7f 19 00 00       	call   80104680 <release>
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
80102d56:	e8 25 1a 00 00       	call   80104780 <memmove>
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
80102d9f:	e8 1c 17 00 00       	call   801044c0 <acquire>
    wakeup(&log);
80102da4:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102dab:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102db2:	00 00 00 
    wakeup(&log);
80102db5:	e8 96 12 00 00       	call   80104050 <wakeup>
    release(&log.lock);
80102dba:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dc1:	e8 ba 18 00 00       	call   80104680 <release>
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
80102de0:	e8 6b 12 00 00       	call   80104050 <wakeup>
  release(&log.lock);
80102de5:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dec:	e8 8f 18 00 00       	call   80104680 <release>
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
80102dff:	68 40 76 10 80       	push   $0x80107640
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
80102e4e:	e8 6d 16 00 00       	call   801044c0 <acquire>
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
80102e9d:	e9 de 17 00 00       	jmp    80104680 <release>
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
80102ec9:	68 4f 76 10 80       	push   $0x8010764f
80102ece:	e8 bd d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102ed3:	83 ec 0c             	sub    $0xc,%esp
80102ed6:	68 65 76 10 80       	push   $0x80107665
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
80102eef:	68 80 76 10 80       	push   $0x80107680
80102ef4:	e8 67 d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102ef9:	e8 12 2b 00 00       	call   80105a10 <idtinit>
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
80102f11:	e8 aa 0c 00 00       	call   80103bc0 <scheduler>
80102f16:	8d 76 00             	lea    0x0(%esi),%esi
80102f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f20 <mpenter>:
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f26:	e8 75 3c 00 00       	call   80106ba0 <switchkvm>
  seginit();
80102f2b:	e8 00 3b 00 00       	call   80106a30 <seginit>
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
80102f57:	68 28 56 11 80       	push   $0x80115628
80102f5c:	e8 9f f4 ff ff       	call   80102400 <kinit1>
  kvmalloc();      // kernel page table
80102f61:	e8 1a 3c 00 00       	call   80106b80 <kvmalloc>
  mpinit();        // detect other processors
80102f66:	e8 b5 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102f6b:	e8 d0 f6 ff ff       	call   80102640 <lapicinit>
  seginit();       // segment descriptors
80102f70:	e8 bb 3a 00 00       	call   80106a30 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f75:	e8 c6 f7 ff ff       	call   80102740 <cpunum>
80102f7a:	5a                   	pop    %edx
80102f7b:	59                   	pop    %ecx
80102f7c:	50                   	push   %eax
80102f7d:	68 91 76 10 80       	push   $0x80107691
80102f82:	e8 d9 d6 ff ff       	call   80100660 <cprintf>
  picinit();       // another interrupt controller
80102f87:	e8 b4 03 00 00       	call   80103340 <picinit>
  ioapicinit();    // another interrupt controller
80102f8c:	e8 7f f2 ff ff       	call   80102210 <ioapicinit>
  consoleinit();   // console hardware
80102f91:	e8 2a da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f96:	e8 65 2d 00 00       	call   80105d00 <uartinit>
  pinit();         // process table
80102f9b:	e8 70 09 00 00       	call   80103910 <pinit>
  tvinit();        // trap vectors
80102fa0:	e8 eb 29 00 00       	call   80105990 <tvinit>
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
80102fd7:	e8 a4 17 00 00       	call   80104780 <memmove>

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
80103085:	e8 a6 08 00 00       	call   80103930 <userinit>
  mpmain();        // finish this processor's setup
8010308a:	e8 51 fe ff ff       	call   80102ee0 <mpmain>
    timerinit();   // uniprocessor timer
8010308f:	e8 9c 28 00 00       	call   80105930 <timerinit>
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
801030ce:	68 a8 76 10 80       	push   $0x801076a8
801030d3:	56                   	push   %esi
801030d4:	e8 47 16 00 00       	call   80104720 <memcmp>
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
80103188:	68 ad 76 10 80       	push   $0x801076ad
8010318d:	56                   	push   %esi
8010318e:	e8 8d 15 00 00       	call   80104720 <memcmp>
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
8010322c:	ff 24 95 b4 76 10 80 	jmp    *-0x7fef894c(,%edx,4)
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
80103310:	55                   	push   %ebp
80103311:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103316:	ba 21 00 00 00       	mov    $0x21,%edx
8010331b:	89 e5                	mov    %esp,%ebp
8010331d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103320:	d3 c0                	rol    %cl,%eax
80103322:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
80103329:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
8010332f:	ee                   	out    %al,(%dx)
80103330:	ba a1 00 00 00       	mov    $0xa1,%edx
80103335:	66 c1 e8 08          	shr    $0x8,%ax
80103339:	ee                   	out    %al,(%dx)
8010333a:	5d                   	pop    %ebp
8010333b:	c3                   	ret    
8010333c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103340 <picinit>:
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
8010335b:	bf 11 00 00 00       	mov    $0x11,%edi
80103360:	be 20 00 00 00       	mov    $0x20,%esi
80103365:	89 f8                	mov    %edi,%eax
80103367:	89 f2                	mov    %esi,%edx
80103369:	ee                   	out    %al,(%dx)
8010336a:	b8 20 00 00 00       	mov    $0x20,%eax
8010336f:	89 da                	mov    %ebx,%edx
80103371:	ee                   	out    %al,(%dx)
80103372:	b8 04 00 00 00       	mov    $0x4,%eax
80103377:	ee                   	out    %al,(%dx)
80103378:	b8 03 00 00 00       	mov    $0x3,%eax
8010337d:	ee                   	out    %al,(%dx)
8010337e:	bb a0 00 00 00       	mov    $0xa0,%ebx
80103383:	89 f8                	mov    %edi,%eax
80103385:	89 da                	mov    %ebx,%edx
80103387:	ee                   	out    %al,(%dx)
80103388:	b8 28 00 00 00       	mov    $0x28,%eax
8010338d:	89 ca                	mov    %ecx,%edx
8010338f:	ee                   	out    %al,(%dx)
80103390:	b8 02 00 00 00       	mov    $0x2,%eax
80103395:	ee                   	out    %al,(%dx)
80103396:	b8 03 00 00 00       	mov    $0x3,%eax
8010339b:	ee                   	out    %al,(%dx)
8010339c:	bf 68 00 00 00       	mov    $0x68,%edi
801033a1:	89 f2                	mov    %esi,%edx
801033a3:	89 f8                	mov    %edi,%eax
801033a5:	ee                   	out    %al,(%dx)
801033a6:	b9 0a 00 00 00       	mov    $0xa,%ecx
801033ab:	89 c8                	mov    %ecx,%eax
801033ad:	ee                   	out    %al,(%dx)
801033ae:	89 f8                	mov    %edi,%eax
801033b0:	89 da                	mov    %ebx,%edx
801033b2:	ee                   	out    %al,(%dx)
801033b3:	89 c8                	mov    %ecx,%eax
801033b5:	ee                   	out    %al,(%dx)
801033b6:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
801033bd:	66 83 f8 ff          	cmp    $0xffff,%ax
801033c1:	74 10                	je     801033d3 <picinit+0x93>
801033c3:	ba 21 00 00 00       	mov    $0x21,%edx
801033c8:	ee                   	out    %al,(%dx)
801033c9:	ba a1 00 00 00       	mov    $0xa1,%edx
801033ce:	66 c1 e8 08          	shr    $0x8,%ax
801033d2:	ee                   	out    %al,(%dx)
801033d3:	5b                   	pop    %ebx
801033d4:	5e                   	pop    %esi
801033d5:	5f                   	pop    %edi
801033d6:	5d                   	pop    %ebp
801033d7:	c3                   	ret    
801033d8:	66 90                	xchg   %ax,%ax
801033da:	66 90                	xchg   %ax,%ax
801033dc:	66 90                	xchg   %ax,%ax
801033de:	66 90                	xchg   %ax,%ax

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
8010349b:	68 c8 76 10 80       	push   $0x801076c8
801034a0:	50                   	push   %eax
801034a1:	e8 fa 0f 00 00       	call   801044a0 <initlock>
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
801034ff:	e8 bc 0f 00 00       	call   801044c0 <acquire>
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
8010351f:	e8 2c 0b 00 00       	call   80104050 <wakeup>
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
80103544:	e9 37 11 00 00       	jmp    80104680 <release>
80103549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103550:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103556:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103559:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103560:	00 00 00 
    wakeup(&p->nwrite);
80103563:	50                   	push   %eax
80103564:	e8 e7 0a 00 00       	call   80104050 <wakeup>
80103569:	83 c4 10             	add    $0x10,%esp
8010356c:	eb b9                	jmp    80103527 <pipeclose+0x37>
8010356e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	53                   	push   %ebx
80103574:	e8 07 11 00 00       	call   80104680 <release>
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
8010359d:	e8 1e 0f 00 00       	call   801044c0 <acquire>
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
80103627:	e8 24 0a 00 00       	call   80104050 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010362c:	59                   	pop    %ecx
8010362d:	58                   	pop    %eax
8010362e:	57                   	push   %edi
8010362f:	53                   	push   %ebx
80103630:	e8 7b 08 00 00       	call   80103eb0 <sleep>
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
80103680:	e8 cb 09 00 00       	call   80104050 <wakeup>
  release(&p->lock);
80103685:	89 3c 24             	mov    %edi,(%esp)
80103688:	e8 f3 0f 00 00       	call   80104680 <release>
  return n;
8010368d:	83 c4 10             	add    $0x10,%esp
80103690:	8b 45 10             	mov    0x10(%ebp),%eax
80103693:	eb 14                	jmp    801036a9 <pipewrite+0x119>
80103695:	8d 76 00             	lea    0x0(%esi),%esi
        release(&p->lock);
80103698:	83 ec 0c             	sub    $0xc,%esp
8010369b:	57                   	push   %edi
8010369c:	e8 df 0f 00 00       	call   80104680 <release>
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
801036d0:	e8 eb 0d 00 00       	call   801044c0 <acquire>
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
80103734:	e8 77 07 00 00       	call   80103eb0 <sleep>
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
8010378f:	e8 bc 08 00 00       	call   80104050 <wakeup>
  release(&p->lock);
80103794:	89 34 24             	mov    %esi,(%esp)
80103797:	e8 e4 0e 00 00       	call   80104680 <release>
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
801037c1:	e8 ba 0e 00 00       	call   80104680 <release>
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
801037f1:	e8 ca 0c 00 00       	call   801044c0 <acquire>
801037f6:	83 c4 10             	add    $0x10,%esp
801037f9:	eb 14                	jmp    8010380f <allocproc+0x2f>
801037fb:	90                   	nop
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103800:	83 eb 80             	sub    $0xffffff80,%ebx
80103803:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80103809:	0f 83 81 00 00 00    	jae    80103890 <allocproc+0xb0>
    if(p->state == UNUSED)
8010380f:	8b 43 0c             	mov    0xc(%ebx),%eax
80103812:	85 c0                	test   %eax,%eax
80103814:	75 ea                	jne    80103800 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103816:	a1 08 a0 10 80       	mov    0x8010a008,%eax
  p->priority = 1;     //default Prioroty

  release(&ptable.lock);
8010381b:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010381e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority = 1;     //default Prioroty
80103825:	c7 43 7c 01 00 00 00 	movl   $0x1,0x7c(%ebx)
  p->pid = nextpid++;
8010382c:	8d 50 01             	lea    0x1(%eax),%edx
8010382f:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103832:	68 a0 2d 11 80       	push   $0x80112da0
  p->pid = nextpid++;
80103837:	89 15 08 a0 10 80    	mov    %edx,0x8010a008
  release(&ptable.lock);
8010383d:	e8 3e 0e 00 00       	call   80104680 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103842:	e8 89 ec ff ff       	call   801024d0 <kalloc>
80103847:	83 c4 10             	add    $0x10,%esp
8010384a:	85 c0                	test   %eax,%eax
8010384c:	89 43 08             	mov    %eax,0x8(%ebx)
8010384f:	74 58                	je     801038a9 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103851:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103857:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010385a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010385f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103862:	c7 40 14 7e 59 10 80 	movl   $0x8010597e,0x14(%eax)
  p->context = (struct context*)sp;
80103869:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010386c:	6a 14                	push   $0x14
8010386e:	6a 00                	push   $0x0
80103870:	50                   	push   %eax
80103871:	e8 5a 0e 00 00       	call   801046d0 <memset>
  p->context->eip = (uint)forkret;
80103876:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103879:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010387c:	c7 40 10 c0 38 10 80 	movl   $0x801038c0,0x10(%eax)
}
80103883:	89 d8                	mov    %ebx,%eax
80103885:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103888:	c9                   	leave  
80103889:	c3                   	ret    
8010388a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103890:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103893:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103895:	68 a0 2d 11 80       	push   $0x80112da0
8010389a:	e8 e1 0d 00 00       	call   80104680 <release>
}
8010389f:	89 d8                	mov    %ebx,%eax
  return 0;
801038a1:	83 c4 10             	add    $0x10,%esp
}
801038a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038a7:	c9                   	leave  
801038a8:	c3                   	ret    
    p->state = UNUSED;
801038a9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801038b0:	31 db                	xor    %ebx,%ebx
801038b2:	eb cf                	jmp    80103883 <allocproc+0xa3>
801038b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038c6:	68 a0 2d 11 80       	push   $0x80112da0
801038cb:	e8 b0 0d 00 00       	call   80104680 <release>

  if (first) {
801038d0:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801038d5:	83 c4 10             	add    $0x10,%esp
801038d8:	85 c0                	test   %eax,%eax
801038da:	75 04                	jne    801038e0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038dc:	c9                   	leave  
801038dd:	c3                   	ret    
801038de:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801038e0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801038e3:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
801038ea:	00 00 00 
    iinit(ROOTDEV);
801038ed:	6a 01                	push   $0x1
801038ef:	e8 8c db ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
801038f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038fb:	e8 a0 f2 ff ff       	call   80102ba0 <initlog>
80103900:	83 c4 10             	add    $0x10,%esp
}
80103903:	c9                   	leave  
80103904:	c3                   	ret    
80103905:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103910 <pinit>:
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103916:	68 cd 76 10 80       	push   $0x801076cd
8010391b:	68 a0 2d 11 80       	push   $0x80112da0
80103920:	e8 7b 0b 00 00       	call   801044a0 <initlock>
}
80103925:	83 c4 10             	add    $0x10,%esp
80103928:	c9                   	leave  
80103929:	c3                   	ret    
8010392a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103930 <userinit>:
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	53                   	push   %ebx
80103934:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103937:	e8 a4 fe ff ff       	call   801037e0 <allocproc>
8010393c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010393e:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
80103943:	e8 c8 31 00 00       	call   80106b10 <setupkvm>
80103948:	85 c0                	test   %eax,%eax
8010394a:	89 43 04             	mov    %eax,0x4(%ebx)
8010394d:	0f 84 bd 00 00 00    	je     80103a10 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103953:	83 ec 04             	sub    $0x4,%esp
80103956:	68 2c 00 00 00       	push   $0x2c
8010395b:	68 60 a4 10 80       	push   $0x8010a460
80103960:	50                   	push   %eax
80103961:	e8 fa 32 00 00       	call   80106c60 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103966:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103969:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010396f:	6a 4c                	push   $0x4c
80103971:	6a 00                	push   $0x0
80103973:	ff 73 18             	pushl  0x18(%ebx)
80103976:	e8 55 0d 00 00       	call   801046d0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010397b:	8b 43 18             	mov    0x18(%ebx),%eax
8010397e:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103983:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103988:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010398b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010398f:	8b 43 18             	mov    0x18(%ebx),%eax
80103992:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103996:	8b 43 18             	mov    0x18(%ebx),%eax
80103999:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010399d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039a1:	8b 43 18             	mov    0x18(%ebx),%eax
801039a4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039a8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039ac:	8b 43 18             	mov    0x18(%ebx),%eax
801039af:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039b6:	8b 43 18             	mov    0x18(%ebx),%eax
801039b9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801039c0:	8b 43 18             	mov    0x18(%ebx),%eax
801039c3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039ca:	8d 43 6c             	lea    0x6c(%ebx),%eax
801039cd:	6a 10                	push   $0x10
801039cf:	68 ed 76 10 80       	push   $0x801076ed
801039d4:	50                   	push   %eax
801039d5:	e8 f6 0e 00 00       	call   801048d0 <safestrcpy>
  p->cwd = namei("/");
801039da:	c7 04 24 f6 76 10 80 	movl   $0x801076f6,(%esp)
801039e1:	e8 da e4 ff ff       	call   80101ec0 <namei>
801039e6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801039e9:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801039f0:	e8 cb 0a 00 00       	call   801044c0 <acquire>
  p->state = RUNNABLE;
801039f5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801039fc:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a03:	e8 78 0c 00 00       	call   80104680 <release>
}
80103a08:	83 c4 10             	add    $0x10,%esp
80103a0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a0e:	c9                   	leave  
80103a0f:	c3                   	ret    
    panic("userinit: out of memory?");
80103a10:	83 ec 0c             	sub    $0xc,%esp
80103a13:	68 d4 76 10 80       	push   $0x801076d4
80103a18:	e8 73 c9 ff ff       	call   80100390 <panic>
80103a1d:	8d 76 00             	lea    0x0(%esi),%esi

80103a20 <growproc>:
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	83 ec 08             	sub    $0x8,%esp
  sz = proc->sz;
80103a26:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103a2d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  sz = proc->sz;
80103a30:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103a32:	83 f9 00             	cmp    $0x0,%ecx
80103a35:	7f 21                	jg     80103a58 <growproc+0x38>
  } else if(n < 0){
80103a37:	75 47                	jne    80103a80 <growproc+0x60>
  proc->sz = sz;
80103a39:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103a3b:	83 ec 0c             	sub    $0xc,%esp
80103a3e:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103a45:	e8 76 31 00 00       	call   80106bc0 <switchuvm>
  return 0;
80103a4a:	83 c4 10             	add    $0x10,%esp
80103a4d:	31 c0                	xor    %eax,%eax
}
80103a4f:	c9                   	leave  
80103a50:	c3                   	ret    
80103a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103a58:	83 ec 04             	sub    $0x4,%esp
80103a5b:	01 c1                	add    %eax,%ecx
80103a5d:	51                   	push   %ecx
80103a5e:	50                   	push   %eax
80103a5f:	ff 72 04             	pushl  0x4(%edx)
80103a62:	e8 39 33 00 00       	call   80106da0 <allocuvm>
80103a67:	83 c4 10             	add    $0x10,%esp
80103a6a:	85 c0                	test   %eax,%eax
80103a6c:	74 28                	je     80103a96 <growproc+0x76>
80103a6e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a75:	eb c2                	jmp    80103a39 <growproc+0x19>
80103a77:	89 f6                	mov    %esi,%esi
80103a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103a80:	83 ec 04             	sub    $0x4,%esp
80103a83:	01 c1                	add    %eax,%ecx
80103a85:	51                   	push   %ecx
80103a86:	50                   	push   %eax
80103a87:	ff 72 04             	pushl  0x4(%edx)
80103a8a:	e8 41 34 00 00       	call   80106ed0 <deallocuvm>
80103a8f:	83 c4 10             	add    $0x10,%esp
80103a92:	85 c0                	test   %eax,%eax
80103a94:	75 d8                	jne    80103a6e <growproc+0x4e>
      return -1;
80103a96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103a9b:	c9                   	leave  
80103a9c:	c3                   	ret    
80103a9d:	8d 76 00             	lea    0x0(%esi),%esi

80103aa0 <fork>:
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	57                   	push   %edi
80103aa4:	56                   	push   %esi
80103aa5:	53                   	push   %ebx
80103aa6:	83 ec 0c             	sub    $0xc,%esp
  if((np = allocproc()) == 0){
80103aa9:	e8 32 fd ff ff       	call   801037e0 <allocproc>
80103aae:	85 c0                	test   %eax,%eax
80103ab0:	0f 84 d6 00 00 00    	je     80103b8c <fork+0xec>
80103ab6:	89 c3                	mov    %eax,%ebx
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103ab8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103abe:	83 ec 08             	sub    $0x8,%esp
80103ac1:	ff 30                	pushl  (%eax)
80103ac3:	ff 70 04             	pushl  0x4(%eax)
80103ac6:	e8 e5 34 00 00       	call   80106fb0 <copyuvm>
80103acb:	83 c4 10             	add    $0x10,%esp
80103ace:	85 c0                	test   %eax,%eax
80103ad0:	89 43 04             	mov    %eax,0x4(%ebx)
80103ad3:	0f 84 ba 00 00 00    	je     80103b93 <fork+0xf3>
  np->sz = proc->sz;
80103ad9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *np->tf = *proc->tf;
80103adf:	8b 7b 18             	mov    0x18(%ebx),%edi
80103ae2:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = proc->sz;
80103ae7:	8b 00                	mov    (%eax),%eax
80103ae9:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103aeb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103af1:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103af4:	8b 70 18             	mov    0x18(%eax),%esi
80103af7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103af9:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103afb:	8b 43 18             	mov    0x18(%ebx),%eax
80103afe:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103b05:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[i])
80103b10:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103b14:	85 c0                	test   %eax,%eax
80103b16:	74 17                	je     80103b2f <fork+0x8f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103b18:	83 ec 0c             	sub    $0xc,%esp
80103b1b:	50                   	push   %eax
80103b1c:	e8 bf d2 ff ff       	call   80100de0 <filedup>
80103b21:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103b25:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103b2c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
80103b2f:	83 c6 01             	add    $0x1,%esi
80103b32:	83 fe 10             	cmp    $0x10,%esi
80103b35:	75 d9                	jne    80103b10 <fork+0x70>
  np->cwd = idup(proc->cwd);
80103b37:	83 ec 0c             	sub    $0xc,%esp
80103b3a:	ff 72 68             	pushl  0x68(%edx)
80103b3d:	e8 0e db ff ff       	call   80101650 <idup>
80103b42:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103b45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103b4b:	83 c4 0c             	add    $0xc,%esp
80103b4e:	6a 10                	push   $0x10
80103b50:	83 c0 6c             	add    $0x6c,%eax
80103b53:	50                   	push   %eax
80103b54:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b57:	50                   	push   %eax
80103b58:	e8 73 0d 00 00       	call   801048d0 <safestrcpy>
  pid = np->pid;
80103b5d:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103b60:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b67:	e8 54 09 00 00       	call   801044c0 <acquire>
  np->state = RUNNABLE;
80103b6c:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103b73:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b7a:	e8 01 0b 00 00       	call   80104680 <release>
  return pid;
80103b7f:	83 c4 10             	add    $0x10,%esp
}
80103b82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b85:	89 f0                	mov    %esi,%eax
80103b87:	5b                   	pop    %ebx
80103b88:	5e                   	pop    %esi
80103b89:	5f                   	pop    %edi
80103b8a:	5d                   	pop    %ebp
80103b8b:	c3                   	ret    
    return -1;
80103b8c:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103b91:	eb ef                	jmp    80103b82 <fork+0xe2>
    kfree(np->kstack);
80103b93:	83 ec 0c             	sub    $0xc,%esp
80103b96:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80103b99:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103b9e:	e8 7d e7 ff ff       	call   80102320 <kfree>
    np->kstack = 0;
80103ba3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103baa:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103bb1:	83 c4 10             	add    $0x10,%esp
80103bb4:	eb cc                	jmp    80103b82 <fork+0xe2>
80103bb6:	8d 76 00             	lea    0x0(%esi),%esi
80103bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bc0 <scheduler>:
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	53                   	push   %ebx
80103bc4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("sti");
80103bc7:	fb                   	sti    
    acquire(&ptable.lock);
80103bc8:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bcb:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
    acquire(&ptable.lock);
80103bd0:	68 a0 2d 11 80       	push   $0x80112da0
80103bd5:	e8 e6 08 00 00       	call   801044c0 <acquire>
80103bda:	83 c4 10             	add    $0x10,%esp
80103bdd:	eb 0c                	jmp    80103beb <scheduler+0x2b>
80103bdf:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103be0:	83 eb 80             	sub    $0xffffff80,%ebx
80103be3:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80103be9:	73 77                	jae    80103c62 <scheduler+0xa2>
      if(p->state != RUNNABLE)
80103beb:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103bef:	75 ef                	jne    80103be0 <scheduler+0x20>
      for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103bf1:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103bf6:	8d 76 00             	lea    0x0(%esi),%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        if(p1->state != RUNNABLE)
80103c00:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103c04:	75 09                	jne    80103c0f <scheduler+0x4f>
        if ( highP->priority < p1->priority )   // larger value, larger priority 
80103c06:	8b 50 7c             	mov    0x7c(%eax),%edx
80103c09:	39 53 7c             	cmp    %edx,0x7c(%ebx)
80103c0c:	0f 4c d8             	cmovl  %eax,%ebx
      for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103c0f:	83 e8 80             	sub    $0xffffff80,%eax
80103c12:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103c17:	72 e7                	jb     80103c00 <scheduler+0x40>
      switchuvm(p);
80103c19:	83 ec 0c             	sub    $0xc,%esp
      proc = p;
80103c1c:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103c23:	53                   	push   %ebx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c24:	83 eb 80             	sub    $0xffffff80,%ebx
      switchuvm(p);
80103c27:	e8 94 2f 00 00       	call   80106bc0 <switchuvm>
      p->state = RUNNING;
80103c2c:	c7 43 8c 04 00 00 00 	movl   $0x4,-0x74(%ebx)
      swtch(&cpu->scheduler, p->context);
80103c33:	58                   	pop    %eax
80103c34:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103c3a:	5a                   	pop    %edx
80103c3b:	ff 73 9c             	pushl  -0x64(%ebx)
80103c3e:	83 c0 04             	add    $0x4,%eax
80103c41:	50                   	push   %eax
80103c42:	e8 e4 0c 00 00       	call   8010492b <swtch>
      switchkvm();
80103c47:	e8 54 2f 00 00       	call   80106ba0 <switchkvm>
      proc = 0;
80103c4c:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c4f:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
      proc = 0;
80103c55:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103c5c:	00 00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c60:	72 89                	jb     80103beb <scheduler+0x2b>
    release(&ptable.lock);
80103c62:	83 ec 0c             	sub    $0xc,%esp
80103c65:	68 a0 2d 11 80       	push   $0x80112da0
80103c6a:	e8 11 0a 00 00       	call   80104680 <release>
  for(;;){
80103c6f:	83 c4 10             	add    $0x10,%esp
80103c72:	e9 50 ff ff ff       	jmp    80103bc7 <scheduler+0x7>
80103c77:	89 f6                	mov    %esi,%esi
80103c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c80 <sched>:
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	53                   	push   %ebx
80103c84:	83 ec 10             	sub    $0x10,%esp
  if(!holding(&ptable.lock))
80103c87:	68 a0 2d 11 80       	push   $0x80112da0
80103c8c:	e8 3f 09 00 00       	call   801045d0 <holding>
80103c91:	83 c4 10             	add    $0x10,%esp
80103c94:	85 c0                	test   %eax,%eax
80103c96:	74 4c                	je     80103ce4 <sched+0x64>
  if(cpu->ncli != 1)
80103c98:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103c9f:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103ca6:	75 63                	jne    80103d0b <sched+0x8b>
  if(proc->state == RUNNING)
80103ca8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103cae:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103cb2:	74 4a                	je     80103cfe <sched+0x7e>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cb4:	9c                   	pushf  
80103cb5:	59                   	pop    %ecx
  if(readeflags()&FL_IF)
80103cb6:	80 e5 02             	and    $0x2,%ch
80103cb9:	75 36                	jne    80103cf1 <sched+0x71>
  swtch(&proc->context, cpu->scheduler);
80103cbb:	83 ec 08             	sub    $0x8,%esp
80103cbe:	83 c0 1c             	add    $0x1c,%eax
  intena = cpu->intena;
80103cc1:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103cc7:	ff 72 04             	pushl  0x4(%edx)
80103cca:	50                   	push   %eax
80103ccb:	e8 5b 0c 00 00       	call   8010492b <swtch>
  cpu->intena = intena;
80103cd0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103cd6:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80103cd9:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103cdf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ce2:	c9                   	leave  
80103ce3:	c3                   	ret    
    panic("sched ptable.lock");
80103ce4:	83 ec 0c             	sub    $0xc,%esp
80103ce7:	68 f8 76 10 80       	push   $0x801076f8
80103cec:	e8 9f c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103cf1:	83 ec 0c             	sub    $0xc,%esp
80103cf4:	68 24 77 10 80       	push   $0x80107724
80103cf9:	e8 92 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103cfe:	83 ec 0c             	sub    $0xc,%esp
80103d01:	68 16 77 10 80       	push   $0x80107716
80103d06:	e8 85 c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103d0b:	83 ec 0c             	sub    $0xc,%esp
80103d0e:	68 0a 77 10 80       	push   $0x8010770a
80103d13:	e8 78 c6 ff ff       	call   80100390 <panic>
80103d18:	90                   	nop
80103d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d20 <exit>:
{
80103d20:	55                   	push   %ebp
  if(proc == initproc)
80103d21:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103d28:	89 e5                	mov    %esp,%ebp
80103d2a:	56                   	push   %esi
80103d2b:	53                   	push   %ebx
80103d2c:	31 db                	xor    %ebx,%ebx
  if(proc == initproc)
80103d2e:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
80103d34:	0f 84 1d 01 00 00    	je     80103e57 <exit+0x137>
80103d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[fd]){
80103d40:	8d 73 08             	lea    0x8(%ebx),%esi
80103d43:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103d47:	85 c0                	test   %eax,%eax
80103d49:	74 1b                	je     80103d66 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103d4b:	83 ec 0c             	sub    $0xc,%esp
80103d4e:	50                   	push   %eax
80103d4f:	e8 dc d0 ff ff       	call   80100e30 <fileclose>
      proc->ofile[fd] = 0;
80103d54:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103d5b:	83 c4 10             	add    $0x10,%esp
80103d5e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103d65:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103d66:	83 c3 01             	add    $0x1,%ebx
80103d69:	83 fb 10             	cmp    $0x10,%ebx
80103d6c:	75 d2                	jne    80103d40 <exit+0x20>
  begin_op();
80103d6e:	e8 cd ee ff ff       	call   80102c40 <begin_op>
  iput(proc->cwd);
80103d73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d79:	83 ec 0c             	sub    $0xc,%esp
80103d7c:	ff 70 68             	pushl  0x68(%eax)
80103d7f:	e8 2c da ff ff       	call   801017b0 <iput>
  end_op();
80103d84:	e8 27 ef ff ff       	call   80102cb0 <end_op>
  proc->cwd = 0;
80103d89:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d8f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
  acquire(&ptable.lock);
80103d96:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d9d:	e8 1e 07 00 00       	call   801044c0 <acquire>
  wakeup1(proc->parent);
80103da2:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80103da9:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dac:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  wakeup1(proc->parent);
80103db1:	8b 53 14             	mov    0x14(%ebx),%edx
80103db4:	eb 14                	jmp    80103dca <exit+0xaa>
80103db6:	8d 76 00             	lea    0x0(%esi),%esi
80103db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dc0:	83 e8 80             	sub    $0xffffff80,%eax
80103dc3:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103dc8:	73 1c                	jae    80103de6 <exit+0xc6>
    if(p->state == SLEEPING && p->chan == chan)
80103dca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dce:	75 f0                	jne    80103dc0 <exit+0xa0>
80103dd0:	3b 50 20             	cmp    0x20(%eax),%edx
80103dd3:	75 eb                	jne    80103dc0 <exit+0xa0>
      p->state = RUNNABLE;
80103dd5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ddc:	83 e8 80             	sub    $0xffffff80,%eax
80103ddf:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103de4:	72 e4                	jb     80103dca <exit+0xaa>
      p->parent = initproc;
80103de6:	8b 0d bc a5 10 80    	mov    0x8010a5bc,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dec:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103df1:	eb 10                	jmp    80103e03 <exit+0xe3>
80103df3:	90                   	nop
80103df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103df8:	83 ea 80             	sub    $0xffffff80,%edx
80103dfb:	81 fa d4 4d 11 80    	cmp    $0x80114dd4,%edx
80103e01:	73 3b                	jae    80103e3e <exit+0x11e>
    if(p->parent == proc){
80103e03:	3b 5a 14             	cmp    0x14(%edx),%ebx
80103e06:	75 f0                	jne    80103df8 <exit+0xd8>
      if(p->state == ZOMBIE)
80103e08:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e0c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e0f:	75 e7                	jne    80103df8 <exit+0xd8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e11:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103e16:	eb 12                	jmp    80103e2a <exit+0x10a>
80103e18:	90                   	nop
80103e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e20:	83 e8 80             	sub    $0xffffff80,%eax
80103e23:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80103e28:	73 ce                	jae    80103df8 <exit+0xd8>
    if(p->state == SLEEPING && p->chan == chan)
80103e2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e2e:	75 f0                	jne    80103e20 <exit+0x100>
80103e30:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e33:	75 eb                	jne    80103e20 <exit+0x100>
      p->state = RUNNABLE;
80103e35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e3c:	eb e2                	jmp    80103e20 <exit+0x100>
  proc->state = ZOMBIE;
80103e3e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103e45:	e8 36 fe ff ff       	call   80103c80 <sched>
  panic("zombie exit");
80103e4a:	83 ec 0c             	sub    $0xc,%esp
80103e4d:	68 45 77 10 80       	push   $0x80107745
80103e52:	e8 39 c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e57:	83 ec 0c             	sub    $0xc,%esp
80103e5a:	68 38 77 10 80       	push   $0x80107738
80103e5f:	e8 2c c5 ff ff       	call   80100390 <panic>
80103e64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e70 <yield>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e76:	68 a0 2d 11 80       	push   $0x80112da0
80103e7b:	e8 40 06 00 00       	call   801044c0 <acquire>
  proc->state = RUNNABLE;
80103e80:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e86:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103e8d:	e8 ee fd ff ff       	call   80103c80 <sched>
  release(&ptable.lock);
80103e92:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e99:	e8 e2 07 00 00       	call   80104680 <release>
}
80103e9e:	83 c4 10             	add    $0x10,%esp
80103ea1:	c9                   	leave  
80103ea2:	c3                   	ret    
80103ea3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103eb0 <sleep>:
  if(proc == 0)
80103eb0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80103eb6:	55                   	push   %ebp
80103eb7:	89 e5                	mov    %esp,%ebp
80103eb9:	56                   	push   %esi
80103eba:	53                   	push   %ebx
  if(proc == 0)
80103ebb:	85 c0                	test   %eax,%eax
{
80103ebd:	8b 75 08             	mov    0x8(%ebp),%esi
80103ec0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103ec3:	0f 84 97 00 00 00    	je     80103f60 <sleep+0xb0>
  if(lk == 0)
80103ec9:	85 db                	test   %ebx,%ebx
80103ecb:	0f 84 82 00 00 00    	je     80103f53 <sleep+0xa3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ed1:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103ed7:	74 57                	je     80103f30 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ed9:	83 ec 0c             	sub    $0xc,%esp
80103edc:	68 a0 2d 11 80       	push   $0x80112da0
80103ee1:	e8 da 05 00 00       	call   801044c0 <acquire>
    release(lk);
80103ee6:	89 1c 24             	mov    %ebx,(%esp)
80103ee9:	e8 92 07 00 00       	call   80104680 <release>
  proc->chan = chan;
80103eee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ef4:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103ef7:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103efe:	e8 7d fd ff ff       	call   80103c80 <sched>
  proc->chan = 0;
80103f03:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f09:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
    release(&ptable.lock);
80103f10:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103f17:	e8 64 07 00 00       	call   80104680 <release>
    acquire(lk);
80103f1c:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103f1f:	83 c4 10             	add    $0x10,%esp
}
80103f22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f25:	5b                   	pop    %ebx
80103f26:	5e                   	pop    %esi
80103f27:	5d                   	pop    %ebp
    acquire(lk);
80103f28:	e9 93 05 00 00       	jmp    801044c0 <acquire>
80103f2d:	8d 76 00             	lea    0x0(%esi),%esi
  proc->chan = chan;
80103f30:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103f33:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103f3a:	e8 41 fd ff ff       	call   80103c80 <sched>
  proc->chan = 0;
80103f3f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f45:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
80103f4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f4f:	5b                   	pop    %ebx
80103f50:	5e                   	pop    %esi
80103f51:	5d                   	pop    %ebp
80103f52:	c3                   	ret    
    panic("sleep without lk");
80103f53:	83 ec 0c             	sub    $0xc,%esp
80103f56:	68 57 77 10 80       	push   $0x80107757
80103f5b:	e8 30 c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f60:	83 ec 0c             	sub    $0xc,%esp
80103f63:	68 51 77 10 80       	push   $0x80107751
80103f68:	e8 23 c4 ff ff       	call   80100390 <panic>
80103f6d:	8d 76 00             	lea    0x0(%esi),%esi

80103f70 <wait>:
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	56                   	push   %esi
80103f74:	53                   	push   %ebx
  acquire(&ptable.lock);
80103f75:	83 ec 0c             	sub    $0xc,%esp
80103f78:	68 a0 2d 11 80       	push   $0x80112da0
80103f7d:	e8 3e 05 00 00       	call   801044c0 <acquire>
80103f82:	83 c4 10             	add    $0x10,%esp
      if(p->parent != proc)
80103f85:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    havekids = 0;
80103f8b:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f8d:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103f92:	eb 0f                	jmp    80103fa3 <wait+0x33>
80103f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f98:	83 eb 80             	sub    $0xffffff80,%ebx
80103f9b:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80103fa1:	73 1b                	jae    80103fbe <wait+0x4e>
      if(p->parent != proc)
80103fa3:	39 43 14             	cmp    %eax,0x14(%ebx)
80103fa6:	75 f0                	jne    80103f98 <wait+0x28>
      if(p->state == ZOMBIE){
80103fa8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fac:	74 32                	je     80103fe0 <wait+0x70>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fae:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80103fb1:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fb6:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80103fbc:	72 e5                	jb     80103fa3 <wait+0x33>
    if(!havekids || proc->killed){
80103fbe:	85 d2                	test   %edx,%edx
80103fc0:	74 74                	je     80104036 <wait+0xc6>
80103fc2:	8b 50 24             	mov    0x24(%eax),%edx
80103fc5:	85 d2                	test   %edx,%edx
80103fc7:	75 6d                	jne    80104036 <wait+0xc6>
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103fc9:	83 ec 08             	sub    $0x8,%esp
80103fcc:	68 a0 2d 11 80       	push   $0x80112da0
80103fd1:	50                   	push   %eax
80103fd2:	e8 d9 fe ff ff       	call   80103eb0 <sleep>
    havekids = 0;
80103fd7:	83 c4 10             	add    $0x10,%esp
80103fda:	eb a9                	jmp    80103f85 <wait+0x15>
80103fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103fe0:	83 ec 0c             	sub    $0xc,%esp
80103fe3:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103fe6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fe9:	e8 32 e3 ff ff       	call   80102320 <kfree>
        freevm(p->pgdir);
80103fee:	59                   	pop    %ecx
80103fef:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103ff2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103ff9:	e8 02 2f 00 00       	call   80106f00 <freevm>
        release(&ptable.lock);
80103ffe:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
        p->pid = 0;
80104005:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010400c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104013:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104017:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010401e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104025:	e8 56 06 00 00       	call   80104680 <release>
        return pid;
8010402a:	83 c4 10             	add    $0x10,%esp
}
8010402d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104030:	89 f0                	mov    %esi,%eax
80104032:	5b                   	pop    %ebx
80104033:	5e                   	pop    %esi
80104034:	5d                   	pop    %ebp
80104035:	c3                   	ret    
      release(&ptable.lock);
80104036:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104039:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010403e:	68 a0 2d 11 80       	push   $0x80112da0
80104043:	e8 38 06 00 00       	call   80104680 <release>
      return -1;
80104048:	83 c4 10             	add    $0x10,%esp
8010404b:	eb e0                	jmp    8010402d <wait+0xbd>
8010404d:	8d 76 00             	lea    0x0(%esi),%esi

80104050 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 10             	sub    $0x10,%esp
80104057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010405a:	68 a0 2d 11 80       	push   $0x80112da0
8010405f:	e8 5c 04 00 00       	call   801044c0 <acquire>
80104064:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104067:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010406c:	eb 0c                	jmp    8010407a <wakeup+0x2a>
8010406e:	66 90                	xchg   %ax,%ax
80104070:	83 e8 80             	sub    $0xffffff80,%eax
80104073:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80104078:	73 1c                	jae    80104096 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010407a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010407e:	75 f0                	jne    80104070 <wakeup+0x20>
80104080:	3b 58 20             	cmp    0x20(%eax),%ebx
80104083:	75 eb                	jne    80104070 <wakeup+0x20>
      p->state = RUNNABLE;
80104085:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010408c:	83 e8 80             	sub    $0xffffff80,%eax
8010408f:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
80104094:	72 e4                	jb     8010407a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104096:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
8010409d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040a0:	c9                   	leave  
  release(&ptable.lock);
801040a1:	e9 da 05 00 00       	jmp    80104680 <release>
801040a6:	8d 76 00             	lea    0x0(%esi),%esi
801040a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040b0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	53                   	push   %ebx
801040b4:	83 ec 10             	sub    $0x10,%esp
801040b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801040ba:	68 a0 2d 11 80       	push   $0x80112da0
801040bf:	e8 fc 03 00 00       	call   801044c0 <acquire>
801040c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040c7:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
801040cc:	eb 0c                	jmp    801040da <kill+0x2a>
801040ce:	66 90                	xchg   %ax,%ax
801040d0:	83 e8 80             	sub    $0xffffff80,%eax
801040d3:	3d d4 4d 11 80       	cmp    $0x80114dd4,%eax
801040d8:	73 36                	jae    80104110 <kill+0x60>
    if(p->pid == pid){
801040da:	39 58 10             	cmp    %ebx,0x10(%eax)
801040dd:	75 f1                	jne    801040d0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040df:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801040e3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801040ea:	75 07                	jne    801040f3 <kill+0x43>
        p->state = RUNNABLE;
801040ec:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801040f3:	83 ec 0c             	sub    $0xc,%esp
801040f6:	68 a0 2d 11 80       	push   $0x80112da0
801040fb:	e8 80 05 00 00       	call   80104680 <release>
      return 0;
80104100:	83 c4 10             	add    $0x10,%esp
80104103:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104105:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104108:	c9                   	leave  
80104109:	c3                   	ret    
8010410a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104110:	83 ec 0c             	sub    $0xc,%esp
80104113:	68 a0 2d 11 80       	push   $0x80112da0
80104118:	e8 63 05 00 00       	call   80104680 <release>
  return -1;
8010411d:	83 c4 10             	add    $0x10,%esp
80104120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104125:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104128:	c9                   	leave  
80104129:	c3                   	ret    
8010412a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104130 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	57                   	push   %edi
80104134:	56                   	push   %esi
80104135:	53                   	push   %ebx
80104136:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104139:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
{
8010413e:	83 ec 3c             	sub    $0x3c,%esp
80104141:	eb 24                	jmp    80104167 <procdump+0x37>
80104143:	90                   	nop
80104144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104148:	83 ec 0c             	sub    $0xc,%esp
8010414b:	68 a6 76 10 80       	push   $0x801076a6
80104150:	e8 0b c5 ff ff       	call   80100660 <cprintf>
80104155:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104158:	83 eb 80             	sub    $0xffffff80,%ebx
8010415b:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80104161:	0f 83 81 00 00 00    	jae    801041e8 <procdump+0xb8>
    if(p->state == UNUSED)
80104167:	8b 43 0c             	mov    0xc(%ebx),%eax
8010416a:	85 c0                	test   %eax,%eax
8010416c:	74 ea                	je     80104158 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010416e:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104171:	ba 68 77 10 80       	mov    $0x80107768,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104176:	77 11                	ja     80104189 <procdump+0x59>
80104178:	8b 14 85 14 78 10 80 	mov    -0x7fef87ec(,%eax,4),%edx
      state = "???";
8010417f:	b8 68 77 10 80       	mov    $0x80107768,%eax
80104184:	85 d2                	test   %edx,%edx
80104186:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104189:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010418c:	50                   	push   %eax
8010418d:	52                   	push   %edx
8010418e:	ff 73 10             	pushl  0x10(%ebx)
80104191:	68 6c 77 10 80       	push   $0x8010776c
80104196:	e8 c5 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010419b:	83 c4 10             	add    $0x10,%esp
8010419e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801041a2:	75 a4                	jne    80104148 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041a4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041a7:	83 ec 08             	sub    $0x8,%esp
801041aa:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041ad:	50                   	push   %eax
801041ae:	8b 43 1c             	mov    0x1c(%ebx),%eax
801041b1:	8b 40 0c             	mov    0xc(%eax),%eax
801041b4:	83 c0 08             	add    $0x8,%eax
801041b7:	50                   	push   %eax
801041b8:	e8 c3 03 00 00       	call   80104580 <getcallerpcs>
801041bd:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801041c0:	8b 17                	mov    (%edi),%edx
801041c2:	85 d2                	test   %edx,%edx
801041c4:	74 82                	je     80104148 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041c6:	83 ec 08             	sub    $0x8,%esp
801041c9:	83 c7 04             	add    $0x4,%edi
801041cc:	52                   	push   %edx
801041cd:	68 c9 71 10 80       	push   $0x801071c9
801041d2:	e8 89 c4 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801041d7:	83 c4 10             	add    $0x10,%esp
801041da:	39 fe                	cmp    %edi,%esi
801041dc:	75 e2                	jne    801041c0 <procdump+0x90>
801041de:	e9 65 ff ff ff       	jmp    80104148 <procdump+0x18>
801041e3:	90                   	nop
801041e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
801041e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041eb:	5b                   	pop    %ebx
801041ec:	5e                   	pop    %esi
801041ed:	5f                   	pop    %edi
801041ee:	5d                   	pop    %ebp
801041ef:	c3                   	ret    

801041f0 <getNumProc>:
// My SYS CALLS
int getNumProc(void){
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	57                   	push   %edi
801041f4:	56                   	push   %esi
801041f5:	53                   	push   %ebx
801041f6:	83 ec 38             	sub    $0x38,%esp
  asm volatile("sti");
801041f9:	fb                   	sti    
	struct proc *p;
	int count=0;
	sti();
	acquire(&ptable.lock);
801041fa:	68 a0 2d 11 80       	push   $0x80112da0
	int count=0;
801041ff:	31 f6                	xor    %esi,%esi
  cprintf("NAME   PID   STATE   PRIORITY\n");
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104201:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80104206:	8d 7d ca             	lea    -0x36(%ebp),%edi
	acquire(&ptable.lock);
80104209:	e8 b2 02 00 00       	call   801044c0 <acquire>
  cprintf("NAME   PID   STATE   PRIORITY\n");
8010420e:	c7 04 24 f4 77 10 80 	movl   $0x801077f4,(%esp)
80104215:	e8 46 c4 ff ff       	call   80100660 <cprintf>
8010421a:	83 c4 10             	add    $0x10,%esp
8010421d:	eb 4b                	jmp    8010426a <getNumProc+0x7a>
8010421f:	90                   	nop
      char state[30];
      if(p->state == EMBRYO){
        strncpy(state,"EMBROY",30);
      }

      if(p->state == SLEEPING){
80104220:	83 f8 02             	cmp    $0x2,%eax
80104223:	74 73                	je     80104298 <getNumProc+0xa8>
        strncpy(state,"SLEEPING",30);
      }

      if(p->state == RUNNABLE){
80104225:	83 f8 03             	cmp    $0x3,%eax
80104228:	0f 84 89 00 00 00    	je     801042b7 <getNumProc+0xc7>
        strncpy(state,"RUNNABLE",30);
      }

      if(p->state == RUNNING){
8010422e:	83 f8 04             	cmp    $0x4,%eax
80104231:	0f 84 9f 00 00 00    	je     801042d6 <getNumProc+0xe6>
        strncpy(state,"RUNNING",30);
      }

      if(p->state == ZOMBIE){
80104237:	83 f8 05             	cmp    $0x5,%eax
8010423a:	0f 84 b5 00 00 00    	je     801042f5 <getNumProc+0x105>
        strncpy(state,"ZOMBIE",30);
        
      }
      cprintf("%s   %d   %s   %d\n",p->name,p->pid,state,p->priority);
80104240:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104243:	83 ec 0c             	sub    $0xc,%esp
80104246:	ff 73 7c             	pushl  0x7c(%ebx)
80104249:	57                   	push   %edi
8010424a:	ff 73 10             	pushl  0x10(%ebx)
8010424d:	50                   	push   %eax
8010424e:	68 9d 77 10 80       	push   $0x8010779d
80104253:	e8 08 c4 ff ff       	call   80100660 <cprintf>
80104258:	83 c4 20             	add    $0x20,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010425b:	83 eb 80             	sub    $0xffffff80,%ebx
8010425e:	81 fb d4 4d 11 80    	cmp    $0x80114dd4,%ebx
80104264:	0f 83 a6 00 00 00    	jae    80104310 <getNumProc+0x120>
		if(p->state == EMBRYO || p->state == SLEEPING || p->state == RUNNABLE || p->state == RUNNING || p->state == ZOMBIE){
8010426a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010426d:	8d 50 ff             	lea    -0x1(%eax),%edx
80104270:	83 fa 04             	cmp    $0x4,%edx
80104273:	77 e6                	ja     8010425b <getNumProc+0x6b>
			count++;
80104275:	83 c6 01             	add    $0x1,%esi
      if(p->state == EMBRYO){
80104278:	83 f8 01             	cmp    $0x1,%eax
8010427b:	75 a3                	jne    80104220 <getNumProc+0x30>
        strncpy(state,"EMBROY",30);
8010427d:	83 ec 04             	sub    $0x4,%esp
80104280:	6a 1e                	push   $0x1e
80104282:	68 75 77 10 80       	push   $0x80107775
80104287:	57                   	push   %edi
80104288:	e8 e3 05 00 00       	call   80104870 <strncpy>
8010428d:	8b 43 0c             	mov    0xc(%ebx),%eax
80104290:	83 c4 10             	add    $0x10,%esp
      if(p->state == SLEEPING){
80104293:	83 f8 02             	cmp    $0x2,%eax
80104296:	75 8d                	jne    80104225 <getNumProc+0x35>
        strncpy(state,"SLEEPING",30);
80104298:	83 ec 04             	sub    $0x4,%esp
8010429b:	6a 1e                	push   $0x1e
8010429d:	68 7c 77 10 80       	push   $0x8010777c
801042a2:	57                   	push   %edi
801042a3:	e8 c8 05 00 00       	call   80104870 <strncpy>
801042a8:	8b 43 0c             	mov    0xc(%ebx),%eax
801042ab:	83 c4 10             	add    $0x10,%esp
      if(p->state == RUNNABLE){
801042ae:	83 f8 03             	cmp    $0x3,%eax
801042b1:	0f 85 77 ff ff ff    	jne    8010422e <getNumProc+0x3e>
        strncpy(state,"RUNNABLE",30);
801042b7:	83 ec 04             	sub    $0x4,%esp
801042ba:	6a 1e                	push   $0x1e
801042bc:	68 85 77 10 80       	push   $0x80107785
801042c1:	57                   	push   %edi
801042c2:	e8 a9 05 00 00       	call   80104870 <strncpy>
801042c7:	8b 43 0c             	mov    0xc(%ebx),%eax
801042ca:	83 c4 10             	add    $0x10,%esp
      if(p->state == RUNNING){
801042cd:	83 f8 04             	cmp    $0x4,%eax
801042d0:	0f 85 61 ff ff ff    	jne    80104237 <getNumProc+0x47>
        strncpy(state,"RUNNING",30);
801042d6:	83 ec 04             	sub    $0x4,%esp
801042d9:	6a 1e                	push   $0x1e
801042db:	68 8e 77 10 80       	push   $0x8010778e
801042e0:	57                   	push   %edi
801042e1:	e8 8a 05 00 00       	call   80104870 <strncpy>
801042e6:	8b 43 0c             	mov    0xc(%ebx),%eax
801042e9:	83 c4 10             	add    $0x10,%esp
      if(p->state == ZOMBIE){
801042ec:	83 f8 05             	cmp    $0x5,%eax
801042ef:	0f 85 4b ff ff ff    	jne    80104240 <getNumProc+0x50>
        strncpy(state,"ZOMBIE",30);
801042f5:	83 ec 04             	sub    $0x4,%esp
801042f8:	6a 1e                	push   $0x1e
801042fa:	68 96 77 10 80       	push   $0x80107796
801042ff:	57                   	push   %edi
80104300:	e8 6b 05 00 00       	call   80104870 <strncpy>
80104305:	83 c4 10             	add    $0x10,%esp
80104308:	e9 33 ff ff ff       	jmp    80104240 <getNumProc+0x50>
8010430d:	8d 76 00             	lea    0x0(%esi),%esi
		}
	}
	cprintf("No. of process is: %d\n",count);
80104310:	83 ec 08             	sub    $0x8,%esp
80104313:	56                   	push   %esi
80104314:	68 b0 77 10 80       	push   $0x801077b0
80104319:	e8 42 c3 ff ff       	call   80100660 <cprintf>
	release(&ptable.lock);
8010431e:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80104325:	e8 56 03 00 00       	call   80104680 <release>
	return 22;	
}
8010432a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010432d:	b8 16 00 00 00       	mov    $0x16,%eax
80104332:	5b                   	pop    %ebx
80104333:	5e                   	pop    %esi
80104334:	5f                   	pop    %edi
80104335:	5d                   	pop    %ebp
80104336:	c3                   	ret    
80104337:	89 f6                	mov    %esi,%esi
80104339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104340 <chpr>:


//For Priority Inversion
int chpr( int pid, int priority )
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	53                   	push   %ebx
80104344:	83 ec 10             	sub    $0x10,%esp
80104347:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010434a:	fb                   	sti    
  struct proc *p;
  sti();
  acquire(&ptable.lock);
8010434b:	68 a0 2d 11 80       	push   $0x80112da0
80104350:	e8 6b 01 00 00       	call   801044c0 <acquire>
80104355:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104358:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
8010435d:	eb 0c                	jmp    8010436b <chpr+0x2b>
8010435f:	90                   	nop
80104360:	83 ea 80             	sub    $0xffffff80,%edx
80104363:	81 fa d4 4d 11 80    	cmp    $0x80114dd4,%edx
80104369:	73 0b                	jae    80104376 <chpr+0x36>
    if(p->pid == pid ) {
8010436b:	39 5a 10             	cmp    %ebx,0x10(%edx)
8010436e:	75 f0                	jne    80104360 <chpr+0x20>
        p->priority = priority;
80104370:	8b 45 0c             	mov    0xc(%ebp),%eax
80104373:	89 42 7c             	mov    %eax,0x7c(%edx)
        break;
    }
  }
  release(&ptable.lock);
80104376:	83 ec 0c             	sub    $0xc,%esp
80104379:	68 a0 2d 11 80       	push   $0x80112da0
8010437e:	e8 fd 02 00 00       	call   80104680 <release>

  return pid;
}
80104383:	89 d8                	mov    %ebx,%eax
80104385:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104388:	c9                   	leave  
80104389:	c3                   	ret    
8010438a:	66 90                	xchg   %ax,%ax
8010438c:	66 90                	xchg   %ax,%ax
8010438e:	66 90                	xchg   %ax,%ax

80104390 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	53                   	push   %ebx
80104394:	83 ec 0c             	sub    $0xc,%esp
80104397:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010439a:	68 2c 78 10 80       	push   $0x8010782c
8010439f:	8d 43 04             	lea    0x4(%ebx),%eax
801043a2:	50                   	push   %eax
801043a3:	e8 f8 00 00 00       	call   801044a0 <initlock>
  lk->name = name;
801043a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801043ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801043b1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801043b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801043bb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801043be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043c1:	c9                   	leave  
801043c2:	c3                   	ret    
801043c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	56                   	push   %esi
801043d4:	53                   	push   %ebx
801043d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043d8:	83 ec 0c             	sub    $0xc,%esp
801043db:	8d 73 04             	lea    0x4(%ebx),%esi
801043de:	56                   	push   %esi
801043df:	e8 dc 00 00 00       	call   801044c0 <acquire>
  while (lk->locked) {
801043e4:	8b 13                	mov    (%ebx),%edx
801043e6:	83 c4 10             	add    $0x10,%esp
801043e9:	85 d2                	test   %edx,%edx
801043eb:	74 16                	je     80104403 <acquiresleep+0x33>
801043ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801043f0:	83 ec 08             	sub    $0x8,%esp
801043f3:	56                   	push   %esi
801043f4:	53                   	push   %ebx
801043f5:	e8 b6 fa ff ff       	call   80103eb0 <sleep>
  while (lk->locked) {
801043fa:	8b 03                	mov    (%ebx),%eax
801043fc:	83 c4 10             	add    $0x10,%esp
801043ff:	85 c0                	test   %eax,%eax
80104401:	75 ed                	jne    801043f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104403:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
80104409:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010440f:	8b 40 10             	mov    0x10(%eax),%eax
80104412:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104415:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104418:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010441b:	5b                   	pop    %ebx
8010441c:	5e                   	pop    %esi
8010441d:	5d                   	pop    %ebp
  release(&lk->lk);
8010441e:	e9 5d 02 00 00       	jmp    80104680 <release>
80104423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104430 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	56                   	push   %esi
80104434:	53                   	push   %ebx
80104435:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104438:	83 ec 0c             	sub    $0xc,%esp
8010443b:	8d 73 04             	lea    0x4(%ebx),%esi
8010443e:	56                   	push   %esi
8010443f:	e8 7c 00 00 00       	call   801044c0 <acquire>
  lk->locked = 0;
80104444:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010444a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104451:	89 1c 24             	mov    %ebx,(%esp)
80104454:	e8 f7 fb ff ff       	call   80104050 <wakeup>
  release(&lk->lk);
80104459:	89 75 08             	mov    %esi,0x8(%ebp)
8010445c:	83 c4 10             	add    $0x10,%esp
}
8010445f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104462:	5b                   	pop    %ebx
80104463:	5e                   	pop    %esi
80104464:	5d                   	pop    %ebp
  release(&lk->lk);
80104465:	e9 16 02 00 00       	jmp    80104680 <release>
8010446a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104470 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	56                   	push   %esi
80104474:	53                   	push   %ebx
80104475:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104478:	83 ec 0c             	sub    $0xc,%esp
8010447b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010447e:	53                   	push   %ebx
8010447f:	e8 3c 00 00 00       	call   801044c0 <acquire>
  r = lk->locked;
80104484:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104486:	89 1c 24             	mov    %ebx,(%esp)
80104489:	e8 f2 01 00 00       	call   80104680 <release>
  return r;
}
8010448e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104491:	89 f0                	mov    %esi,%eax
80104493:	5b                   	pop    %ebx
80104494:	5e                   	pop    %esi
80104495:	5d                   	pop    %ebp
80104496:	c3                   	ret    
80104497:	66 90                	xchg   %ax,%ax
80104499:	66 90                	xchg   %ax,%ax
8010449b:	66 90                	xchg   %ax,%ax
8010449d:	66 90                	xchg   %ax,%ax
8010449f:	90                   	nop

801044a0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801044a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801044a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801044af:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801044b2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801044b9:	5d                   	pop    %ebp
801044ba:	c3                   	ret    
801044bb:	90                   	nop
801044bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044c0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	53                   	push   %ebx
801044c4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044c7:	9c                   	pushf  
801044c8:	5a                   	pop    %edx
  asm volatile("cli");
801044c9:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801044ca:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
801044d1:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
801044d7:	85 c0                	test   %eax,%eax
801044d9:	75 0c                	jne    801044e7 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
801044db:	81 e2 00 02 00 00    	and    $0x200,%edx
801044e1:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
  if(holding(lk))
801044e7:	8b 55 08             	mov    0x8(%ebp),%edx
  cpu->ncli += 1;
801044ea:	83 c0 01             	add    $0x1,%eax
801044ed:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)
  return lock->locked && lock->cpu == cpu;
801044f3:	8b 02                	mov    (%edx),%eax
801044f5:	85 c0                	test   %eax,%eax
801044f7:	74 05                	je     801044fe <acquire+0x3e>
801044f9:	39 4a 08             	cmp    %ecx,0x8(%edx)
801044fc:	74 74                	je     80104572 <acquire+0xb2>
  asm volatile("lock; xchgl %0, %1" :
801044fe:	b9 01 00 00 00       	mov    $0x1,%ecx
80104503:	90                   	nop
80104504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104508:	89 c8                	mov    %ecx,%eax
8010450a:	f0 87 02             	lock xchg %eax,(%edx)
  while(xchg(&lk->locked, 1) != 0)
8010450d:	85 c0                	test   %eax,%eax
8010450f:	75 f7                	jne    80104508 <acquire+0x48>
  __sync_synchronize();
80104511:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = cpu;
80104516:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104519:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  for(i = 0; i < 10; i++){
8010451f:	31 d2                	xor    %edx,%edx
  lk->cpu = cpu;
80104521:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
80104524:	83 c1 0c             	add    $0xc,%ecx
  ebp = (uint*)v - 2;
80104527:	89 e8                	mov    %ebp,%eax
80104529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104530:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104536:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010453c:	77 1a                	ja     80104558 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
8010453e:	8b 58 04             	mov    0x4(%eax),%ebx
80104541:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104544:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104547:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104549:	83 fa 0a             	cmp    $0xa,%edx
8010454c:	75 e2                	jne    80104530 <acquire+0x70>
}
8010454e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104551:	c9                   	leave  
80104552:	c3                   	ret    
80104553:	90                   	nop
80104554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104558:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010455b:	83 c1 28             	add    $0x28,%ecx
8010455e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104560:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104566:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104569:	39 c8                	cmp    %ecx,%eax
8010456b:	75 f3                	jne    80104560 <acquire+0xa0>
}
8010456d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104570:	c9                   	leave  
80104571:	c3                   	ret    
    panic("acquire");
80104572:	83 ec 0c             	sub    $0xc,%esp
80104575:	68 37 78 10 80       	push   $0x80107837
8010457a:	e8 11 be ff ff       	call   80100390 <panic>
8010457f:	90                   	nop

80104580 <getcallerpcs>:
{
80104580:	55                   	push   %ebp
  for(i = 0; i < 10; i++){
80104581:	31 d2                	xor    %edx,%edx
{
80104583:	89 e5                	mov    %esp,%ebp
80104585:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104586:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104589:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010458c:	83 e8 08             	sub    $0x8,%eax
8010458f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104590:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104596:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010459c:	77 1a                	ja     801045b8 <getcallerpcs+0x38>
    pcs[i] = ebp[1];     // saved %eip
8010459e:	8b 58 04             	mov    0x4(%eax),%ebx
801045a1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801045a4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801045a7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801045a9:	83 fa 0a             	cmp    $0xa,%edx
801045ac:	75 e2                	jne    80104590 <getcallerpcs+0x10>
}
801045ae:	5b                   	pop    %ebx
801045af:	5d                   	pop    %ebp
801045b0:	c3                   	ret    
801045b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045b8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801045bb:	83 c1 28             	add    $0x28,%ecx
801045be:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801045c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801045c6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801045c9:	39 c1                	cmp    %eax,%ecx
801045cb:	75 f3                	jne    801045c0 <getcallerpcs+0x40>
}
801045cd:	5b                   	pop    %ebx
801045ce:	5d                   	pop    %ebp
801045cf:	c3                   	ret    

801045d0 <holding>:
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
801045d6:	8b 02                	mov    (%edx),%eax
801045d8:	85 c0                	test   %eax,%eax
801045da:	74 14                	je     801045f0 <holding+0x20>
801045dc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801045e2:	39 42 08             	cmp    %eax,0x8(%edx)
}
801045e5:	5d                   	pop    %ebp
  return lock->locked && lock->cpu == cpu;
801045e6:	0f 94 c0             	sete   %al
801045e9:	0f b6 c0             	movzbl %al,%eax
}
801045ec:	c3                   	ret    
801045ed:	8d 76 00             	lea    0x0(%esi),%esi
801045f0:	31 c0                	xor    %eax,%eax
801045f2:	5d                   	pop    %ebp
801045f3:	c3                   	ret    
801045f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104600 <pushcli>:
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104603:	9c                   	pushf  
80104604:	59                   	pop    %ecx
  asm volatile("cli");
80104605:	fa                   	cli    
  if(cpu->ncli == 0)
80104606:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010460d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104613:	85 c0                	test   %eax,%eax
80104615:	75 0c                	jne    80104623 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
80104617:	81 e1 00 02 00 00    	and    $0x200,%ecx
8010461d:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
80104623:	83 c0 01             	add    $0x1,%eax
80104626:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
8010462c:	5d                   	pop    %ebp
8010462d:	c3                   	ret    
8010462e:	66 90                	xchg   %ax,%ax

80104630 <popcli>:

void
popcli(void)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104636:	9c                   	pushf  
80104637:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104638:	f6 c4 02             	test   $0x2,%ah
8010463b:	75 2c                	jne    80104669 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
8010463d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104644:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
8010464b:	78 0f                	js     8010465c <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
8010464d:	75 0b                	jne    8010465a <popcli+0x2a>
8010464f:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104655:	85 c0                	test   %eax,%eax
80104657:	74 01                	je     8010465a <popcli+0x2a>
  asm volatile("sti");
80104659:	fb                   	sti    
    sti();
}
8010465a:	c9                   	leave  
8010465b:	c3                   	ret    
    panic("popcli");
8010465c:	83 ec 0c             	sub    $0xc,%esp
8010465f:	68 56 78 10 80       	push   $0x80107856
80104664:	e8 27 bd ff ff       	call   80100390 <panic>
    panic("popcli - interruptible");
80104669:	83 ec 0c             	sub    $0xc,%esp
8010466c:	68 3f 78 10 80       	push   $0x8010783f
80104671:	e8 1a bd ff ff       	call   80100390 <panic>
80104676:	8d 76 00             	lea    0x0(%esi),%esi
80104679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104680 <release>:
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	83 ec 08             	sub    $0x8,%esp
80104686:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == cpu;
80104689:	8b 10                	mov    (%eax),%edx
8010468b:	85 d2                	test   %edx,%edx
8010468d:	74 2b                	je     801046ba <release+0x3a>
8010468f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104696:	39 50 08             	cmp    %edx,0x8(%eax)
80104699:	75 1f                	jne    801046ba <release+0x3a>
  lk->pcs[0] = 0;
8010469b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801046a2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  __sync_synchronize();
801046a9:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801046ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
801046b4:	c9                   	leave  
  popcli();
801046b5:	e9 76 ff ff ff       	jmp    80104630 <popcli>
    panic("release");
801046ba:	83 ec 0c             	sub    $0xc,%esp
801046bd:	68 5d 78 10 80       	push   $0x8010785d
801046c2:	e8 c9 bc ff ff       	call   80100390 <panic>
801046c7:	66 90                	xchg   %ax,%ax
801046c9:	66 90                	xchg   %ax,%ax
801046cb:	66 90                	xchg   %ax,%ax
801046cd:	66 90                	xchg   %ax,%ax
801046cf:	90                   	nop

801046d0 <memset>:
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	57                   	push   %edi
801046d4:	53                   	push   %ebx
801046d5:	8b 55 08             	mov    0x8(%ebp),%edx
801046d8:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046db:	f6 c2 03             	test   $0x3,%dl
801046de:	75 05                	jne    801046e5 <memset+0x15>
801046e0:	f6 c1 03             	test   $0x3,%cl
801046e3:	74 13                	je     801046f8 <memset+0x28>
801046e5:	89 d7                	mov    %edx,%edi
801046e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ea:	fc                   	cld    
801046eb:	f3 aa                	rep stos %al,%es:(%edi)
801046ed:	5b                   	pop    %ebx
801046ee:	89 d0                	mov    %edx,%eax
801046f0:	5f                   	pop    %edi
801046f1:	5d                   	pop    %ebp
801046f2:	c3                   	ret    
801046f3:	90                   	nop
801046f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046f8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
801046fc:	c1 e9 02             	shr    $0x2,%ecx
801046ff:	89 fb                	mov    %edi,%ebx
80104701:	89 f8                	mov    %edi,%eax
80104703:	c1 e3 18             	shl    $0x18,%ebx
80104706:	c1 e0 10             	shl    $0x10,%eax
80104709:	09 d8                	or     %ebx,%eax
8010470b:	09 f8                	or     %edi,%eax
8010470d:	c1 e7 08             	shl    $0x8,%edi
80104710:	09 f8                	or     %edi,%eax
80104712:	89 d7                	mov    %edx,%edi
80104714:	fc                   	cld    
80104715:	f3 ab                	rep stos %eax,%es:(%edi)
80104717:	5b                   	pop    %ebx
80104718:	89 d0                	mov    %edx,%eax
8010471a:	5f                   	pop    %edi
8010471b:	5d                   	pop    %ebp
8010471c:	c3                   	ret    
8010471d:	8d 76 00             	lea    0x0(%esi),%esi

80104720 <memcmp>:
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	57                   	push   %edi
80104724:	56                   	push   %esi
80104725:	8b 45 10             	mov    0x10(%ebp),%eax
80104728:	53                   	push   %ebx
80104729:	8b 75 0c             	mov    0xc(%ebp),%esi
8010472c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010472f:	85 c0                	test   %eax,%eax
80104731:	74 29                	je     8010475c <memcmp+0x3c>
80104733:	0f b6 13             	movzbl (%ebx),%edx
80104736:	0f b6 0e             	movzbl (%esi),%ecx
80104739:	38 d1                	cmp    %dl,%cl
8010473b:	75 2b                	jne    80104768 <memcmp+0x48>
8010473d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104740:	31 c0                	xor    %eax,%eax
80104742:	eb 14                	jmp    80104758 <memcmp+0x38>
80104744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104748:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010474d:	83 c0 01             	add    $0x1,%eax
80104750:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104754:	38 ca                	cmp    %cl,%dl
80104756:	75 10                	jne    80104768 <memcmp+0x48>
80104758:	39 f8                	cmp    %edi,%eax
8010475a:	75 ec                	jne    80104748 <memcmp+0x28>
8010475c:	5b                   	pop    %ebx
8010475d:	31 c0                	xor    %eax,%eax
8010475f:	5e                   	pop    %esi
80104760:	5f                   	pop    %edi
80104761:	5d                   	pop    %ebp
80104762:	c3                   	ret    
80104763:	90                   	nop
80104764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104768:	0f b6 c2             	movzbl %dl,%eax
8010476b:	5b                   	pop    %ebx
8010476c:	29 c8                	sub    %ecx,%eax
8010476e:	5e                   	pop    %esi
8010476f:	5f                   	pop    %edi
80104770:	5d                   	pop    %ebp
80104771:	c3                   	ret    
80104772:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104780 <memmove>:
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	56                   	push   %esi
80104784:	53                   	push   %ebx
80104785:	8b 45 08             	mov    0x8(%ebp),%eax
80104788:	8b 75 0c             	mov    0xc(%ebp),%esi
8010478b:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010478e:	39 c6                	cmp    %eax,%esi
80104790:	73 2e                	jae    801047c0 <memmove+0x40>
80104792:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104795:	39 c8                	cmp    %ecx,%eax
80104797:	73 27                	jae    801047c0 <memmove+0x40>
80104799:	85 db                	test   %ebx,%ebx
8010479b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010479e:	74 17                	je     801047b7 <memmove+0x37>
801047a0:	29 d9                	sub    %ebx,%ecx
801047a2:	89 cb                	mov    %ecx,%ebx
801047a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047a8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801047ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801047af:	83 ea 01             	sub    $0x1,%edx
801047b2:	83 fa ff             	cmp    $0xffffffff,%edx
801047b5:	75 f1                	jne    801047a8 <memmove+0x28>
801047b7:	5b                   	pop    %ebx
801047b8:	5e                   	pop    %esi
801047b9:	5d                   	pop    %ebp
801047ba:	c3                   	ret    
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047c0:	31 d2                	xor    %edx,%edx
801047c2:	85 db                	test   %ebx,%ebx
801047c4:	74 f1                	je     801047b7 <memmove+0x37>
801047c6:	8d 76 00             	lea    0x0(%esi),%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801047d0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801047d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801047d7:	83 c2 01             	add    $0x1,%edx
801047da:	39 d3                	cmp    %edx,%ebx
801047dc:	75 f2                	jne    801047d0 <memmove+0x50>
801047de:	5b                   	pop    %ebx
801047df:	5e                   	pop    %esi
801047e0:	5d                   	pop    %ebp
801047e1:	c3                   	ret    
801047e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047f0 <memcpy>:
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	5d                   	pop    %ebp
801047f4:	eb 8a                	jmp    80104780 <memmove>
801047f6:	8d 76 00             	lea    0x0(%esi),%esi
801047f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104800 <strncmp>:
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	56                   	push   %esi
80104805:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104808:	53                   	push   %ebx
80104809:	8b 7d 08             	mov    0x8(%ebp),%edi
8010480c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010480f:	85 c9                	test   %ecx,%ecx
80104811:	74 37                	je     8010484a <strncmp+0x4a>
80104813:	0f b6 17             	movzbl (%edi),%edx
80104816:	0f b6 1e             	movzbl (%esi),%ebx
80104819:	84 d2                	test   %dl,%dl
8010481b:	74 3f                	je     8010485c <strncmp+0x5c>
8010481d:	38 d3                	cmp    %dl,%bl
8010481f:	75 3b                	jne    8010485c <strncmp+0x5c>
80104821:	8d 47 01             	lea    0x1(%edi),%eax
80104824:	01 cf                	add    %ecx,%edi
80104826:	eb 1b                	jmp    80104843 <strncmp+0x43>
80104828:	90                   	nop
80104829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104830:	0f b6 10             	movzbl (%eax),%edx
80104833:	84 d2                	test   %dl,%dl
80104835:	74 21                	je     80104858 <strncmp+0x58>
80104837:	0f b6 19             	movzbl (%ecx),%ebx
8010483a:	83 c0 01             	add    $0x1,%eax
8010483d:	89 ce                	mov    %ecx,%esi
8010483f:	38 da                	cmp    %bl,%dl
80104841:	75 19                	jne    8010485c <strncmp+0x5c>
80104843:	39 c7                	cmp    %eax,%edi
80104845:	8d 4e 01             	lea    0x1(%esi),%ecx
80104848:	75 e6                	jne    80104830 <strncmp+0x30>
8010484a:	5b                   	pop    %ebx
8010484b:	31 c0                	xor    %eax,%eax
8010484d:	5e                   	pop    %esi
8010484e:	5f                   	pop    %edi
8010484f:	5d                   	pop    %ebp
80104850:	c3                   	ret    
80104851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104858:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
8010485c:	0f b6 c2             	movzbl %dl,%eax
8010485f:	29 d8                	sub    %ebx,%eax
80104861:	5b                   	pop    %ebx
80104862:	5e                   	pop    %esi
80104863:	5f                   	pop    %edi
80104864:	5d                   	pop    %ebp
80104865:	c3                   	ret    
80104866:	8d 76 00             	lea    0x0(%esi),%esi
80104869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104870 <strncpy>:
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	56                   	push   %esi
80104874:	53                   	push   %ebx
80104875:	8b 45 08             	mov    0x8(%ebp),%eax
80104878:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010487b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010487e:	89 c2                	mov    %eax,%edx
80104880:	eb 19                	jmp    8010489b <strncpy+0x2b>
80104882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104888:	83 c3 01             	add    $0x1,%ebx
8010488b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010488f:	83 c2 01             	add    $0x1,%edx
80104892:	84 c9                	test   %cl,%cl
80104894:	88 4a ff             	mov    %cl,-0x1(%edx)
80104897:	74 09                	je     801048a2 <strncpy+0x32>
80104899:	89 f1                	mov    %esi,%ecx
8010489b:	85 c9                	test   %ecx,%ecx
8010489d:	8d 71 ff             	lea    -0x1(%ecx),%esi
801048a0:	7f e6                	jg     80104888 <strncpy+0x18>
801048a2:	31 c9                	xor    %ecx,%ecx
801048a4:	85 f6                	test   %esi,%esi
801048a6:	7e 17                	jle    801048bf <strncpy+0x4f>
801048a8:	90                   	nop
801048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048b0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801048b4:	89 f3                	mov    %esi,%ebx
801048b6:	83 c1 01             	add    $0x1,%ecx
801048b9:	29 cb                	sub    %ecx,%ebx
801048bb:	85 db                	test   %ebx,%ebx
801048bd:	7f f1                	jg     801048b0 <strncpy+0x40>
801048bf:	5b                   	pop    %ebx
801048c0:	5e                   	pop    %esi
801048c1:	5d                   	pop    %ebp
801048c2:	c3                   	ret    
801048c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <safestrcpy>:
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
801048d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048d8:	8b 45 08             	mov    0x8(%ebp),%eax
801048db:	8b 55 0c             	mov    0xc(%ebp),%edx
801048de:	85 c9                	test   %ecx,%ecx
801048e0:	7e 26                	jle    80104908 <safestrcpy+0x38>
801048e2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801048e6:	89 c1                	mov    %eax,%ecx
801048e8:	eb 17                	jmp    80104901 <safestrcpy+0x31>
801048ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048f0:	83 c2 01             	add    $0x1,%edx
801048f3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801048f7:	83 c1 01             	add    $0x1,%ecx
801048fa:	84 db                	test   %bl,%bl
801048fc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801048ff:	74 04                	je     80104905 <safestrcpy+0x35>
80104901:	39 f2                	cmp    %esi,%edx
80104903:	75 eb                	jne    801048f0 <safestrcpy+0x20>
80104905:	c6 01 00             	movb   $0x0,(%ecx)
80104908:	5b                   	pop    %ebx
80104909:	5e                   	pop    %esi
8010490a:	5d                   	pop    %ebp
8010490b:	c3                   	ret    
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <strlen>:
80104910:	55                   	push   %ebp
80104911:	31 c0                	xor    %eax,%eax
80104913:	89 e5                	mov    %esp,%ebp
80104915:	8b 55 08             	mov    0x8(%ebp),%edx
80104918:	80 3a 00             	cmpb   $0x0,(%edx)
8010491b:	74 0c                	je     80104929 <strlen+0x19>
8010491d:	8d 76 00             	lea    0x0(%esi),%esi
80104920:	83 c0 01             	add    $0x1,%eax
80104923:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104927:	75 f7                	jne    80104920 <strlen+0x10>
80104929:	5d                   	pop    %ebp
8010492a:	c3                   	ret    

8010492b <swtch>:
8010492b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010492f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104933:	55                   	push   %ebp
80104934:	53                   	push   %ebx
80104935:	56                   	push   %esi
80104936:	57                   	push   %edi
80104937:	89 20                	mov    %esp,(%eax)
80104939:	89 d4                	mov    %edx,%esp
8010493b:	5f                   	pop    %edi
8010493c:	5e                   	pop    %esi
8010493d:	5b                   	pop    %ebx
8010493e:	5d                   	pop    %ebp
8010493f:	c3                   	ret    

80104940 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104940:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104941:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80104948:	89 e5                	mov    %esp,%ebp
8010494a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
8010494d:	8b 12                	mov    (%edx),%edx
8010494f:	39 c2                	cmp    %eax,%edx
80104951:	76 15                	jbe    80104968 <fetchint+0x28>
80104953:	8d 48 04             	lea    0x4(%eax),%ecx
80104956:	39 ca                	cmp    %ecx,%edx
80104958:	72 0e                	jb     80104968 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010495a:	8b 10                	mov    (%eax),%edx
8010495c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010495f:	89 10                	mov    %edx,(%eax)
  return 0;
80104961:	31 c0                	xor    %eax,%eax
}
80104963:	5d                   	pop    %ebp
80104964:	c3                   	ret    
80104965:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010496d:	5d                   	pop    %ebp
8010496e:	c3                   	ret    
8010496f:	90                   	nop

80104970 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104970:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104971:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80104977:	89 e5                	mov    %esp,%ebp
80104979:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz)
8010497c:	39 08                	cmp    %ecx,(%eax)
8010497e:	76 2c                	jbe    801049ac <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104980:	8b 55 0c             	mov    0xc(%ebp),%edx
80104983:	89 c8                	mov    %ecx,%eax
80104985:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104987:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010498e:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104990:	39 d1                	cmp    %edx,%ecx
80104992:	73 18                	jae    801049ac <fetchstr+0x3c>
    if(*s == 0)
80104994:	80 39 00             	cmpb   $0x0,(%ecx)
80104997:	75 0c                	jne    801049a5 <fetchstr+0x35>
80104999:	eb 25                	jmp    801049c0 <fetchstr+0x50>
8010499b:	90                   	nop
8010499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049a0:	80 38 00             	cmpb   $0x0,(%eax)
801049a3:	74 13                	je     801049b8 <fetchstr+0x48>
  for(s = *pp; s < ep; s++)
801049a5:	83 c0 01             	add    $0x1,%eax
801049a8:	39 c2                	cmp    %eax,%edx
801049aa:	77 f4                	ja     801049a0 <fetchstr+0x30>
    return -1;
801049ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  return -1;
}
801049b1:	5d                   	pop    %ebp
801049b2:	c3                   	ret    
801049b3:	90                   	nop
801049b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049b8:	29 c8                	sub    %ecx,%eax
801049ba:	5d                   	pop    %ebp
801049bb:	c3                   	ret    
801049bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
801049c0:	31 c0                	xor    %eax,%eax
}
801049c2:	5d                   	pop    %ebp
801049c3:	c3                   	ret    
801049c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801049d0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049d0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
801049d7:	55                   	push   %ebp
801049d8:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049da:	8b 42 18             	mov    0x18(%edx),%eax
801049dd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
801049e0:	8b 12                	mov    (%edx),%edx
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049e2:	8b 40 44             	mov    0x44(%eax),%eax
801049e5:	8d 04 88             	lea    (%eax,%ecx,4),%eax
801049e8:	8d 48 04             	lea    0x4(%eax),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
801049eb:	39 d1                	cmp    %edx,%ecx
801049ed:	73 19                	jae    80104a08 <argint+0x38>
801049ef:	8d 48 08             	lea    0x8(%eax),%ecx
801049f2:	39 ca                	cmp    %ecx,%edx
801049f4:	72 12                	jb     80104a08 <argint+0x38>
  *ip = *(int*)(addr);
801049f6:	8b 50 04             	mov    0x4(%eax),%edx
801049f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801049fc:	89 10                	mov    %edx,(%eax)
  return 0;
801049fe:	31 c0                	xor    %eax,%eax
}
80104a00:	5d                   	pop    %ebp
80104a01:	c3                   	ret    
80104a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104a08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a0d:	5d                   	pop    %ebp
80104a0e:	c3                   	ret    
80104a0f:	90                   	nop

80104a10 <argptr>:
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a10:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a16:	55                   	push   %ebp
80104a17:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a19:	8b 50 18             	mov    0x18(%eax),%edx
80104a1c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a1f:	8b 00                	mov    (%eax),%eax
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a21:	8b 52 44             	mov    0x44(%edx),%edx
80104a24:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104a27:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a2a:	39 c1                	cmp    %eax,%ecx
80104a2c:	73 22                	jae    80104a50 <argptr+0x40>
80104a2e:	8d 4a 08             	lea    0x8(%edx),%ecx
80104a31:	39 c8                	cmp    %ecx,%eax
80104a33:	72 1b                	jb     80104a50 <argptr+0x40>
  *ip = *(int*)(addr);
80104a35:	8b 52 04             	mov    0x4(%edx),%edx
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80104a38:	39 c2                	cmp    %eax,%edx
80104a3a:	73 14                	jae    80104a50 <argptr+0x40>
80104a3c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a3f:	01 d1                	add    %edx,%ecx
80104a41:	39 c1                	cmp    %eax,%ecx
80104a43:	77 0b                	ja     80104a50 <argptr+0x40>
    return -1;
  *pp = (char*)i;
80104a45:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a48:	89 10                	mov    %edx,(%eax)
  return 0;
80104a4a:	31 c0                	xor    %eax,%eax
}
80104a4c:	5d                   	pop    %ebp
80104a4d:	c3                   	ret    
80104a4e:	66 90                	xchg   %ax,%ax
    return -1;
80104a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a55:	5d                   	pop    %ebp
80104a56:	c3                   	ret    
80104a57:	89 f6                	mov    %esi,%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a60 <argstr>:
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a66:	55                   	push   %ebp
80104a67:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a69:	8b 50 18             	mov    0x18(%eax),%edx
80104a6c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a6f:	8b 00                	mov    (%eax),%eax
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a71:	8b 52 44             	mov    0x44(%edx),%edx
80104a74:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104a77:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a7a:	39 c1                	cmp    %eax,%ecx
80104a7c:	73 3e                	jae    80104abc <argstr+0x5c>
80104a7e:	8d 4a 08             	lea    0x8(%edx),%ecx
80104a81:	39 c8                	cmp    %ecx,%eax
80104a83:	72 37                	jb     80104abc <argstr+0x5c>
  *ip = *(int*)(addr);
80104a85:	8b 4a 04             	mov    0x4(%edx),%ecx
  if(addr >= proc->sz)
80104a88:	39 c1                	cmp    %eax,%ecx
80104a8a:	73 30                	jae    80104abc <argstr+0x5c>
  *pp = (char*)addr;
80104a8c:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a8f:	89 c8                	mov    %ecx,%eax
80104a91:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104a93:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a9a:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104a9c:	39 d1                	cmp    %edx,%ecx
80104a9e:	73 1c                	jae    80104abc <argstr+0x5c>
    if(*s == 0)
80104aa0:	80 39 00             	cmpb   $0x0,(%ecx)
80104aa3:	75 10                	jne    80104ab5 <argstr+0x55>
80104aa5:	eb 29                	jmp    80104ad0 <argstr+0x70>
80104aa7:	89 f6                	mov    %esi,%esi
80104aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ab0:	80 38 00             	cmpb   $0x0,(%eax)
80104ab3:	74 13                	je     80104ac8 <argstr+0x68>
  for(s = *pp; s < ep; s++)
80104ab5:	83 c0 01             	add    $0x1,%eax
80104ab8:	39 c2                	cmp    %eax,%edx
80104aba:	77 f4                	ja     80104ab0 <argstr+0x50>
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104abc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104ac1:	5d                   	pop    %ebp
80104ac2:	c3                   	ret    
80104ac3:	90                   	nop
80104ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ac8:	29 c8                	sub    %ecx,%eax
80104aca:	5d                   	pop    %ebp
80104acb:	c3                   	ret    
80104acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
80104ad0:	31 c0                	xor    %eax,%eax
}
80104ad2:	5d                   	pop    %ebp
80104ad3:	c3                   	ret    
80104ad4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ada:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ae0 <syscall>:
[SYS_chpr]         sys_chpr, 
};

void
syscall(void)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	83 ec 08             	sub    $0x8,%esp
  int num;

  num = proc->tf->eax;
80104ae6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104aed:	8b 42 18             	mov    0x18(%edx),%eax
80104af0:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104af3:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104af6:	83 f9 16             	cmp    $0x16,%ecx
80104af9:	77 25                	ja     80104b20 <syscall+0x40>
80104afb:	8b 0c 85 a0 78 10 80 	mov    -0x7fef8760(,%eax,4),%ecx
80104b02:	85 c9                	test   %ecx,%ecx
80104b04:	74 1a                	je     80104b20 <syscall+0x40>
    proc->tf->eax = syscalls[num]();
80104b06:	ff d1                	call   *%ecx
80104b08:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b0f:	8b 52 18             	mov    0x18(%edx),%edx
80104b12:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104b15:	c9                   	leave  
80104b16:	c3                   	ret    
80104b17:	89 f6                	mov    %esi,%esi
80104b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("%d %s: unknown sys call %d\n",
80104b20:	50                   	push   %eax
            proc->pid, proc->name, num);
80104b21:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104b24:	50                   	push   %eax
80104b25:	ff 72 10             	pushl  0x10(%edx)
80104b28:	68 65 78 10 80       	push   $0x80107865
80104b2d:	e8 2e bb ff ff       	call   80100660 <cprintf>
    proc->tf->eax = -1;
80104b32:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b38:	83 c4 10             	add    $0x10,%esp
80104b3b:	8b 40 18             	mov    0x18(%eax),%eax
80104b3e:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104b45:	c9                   	leave  
80104b46:	c3                   	ret    
80104b47:	66 90                	xchg   %ax,%ax
80104b49:	66 90                	xchg   %ax,%ax
80104b4b:	66 90                	xchg   %ax,%ax
80104b4d:	66 90                	xchg   %ax,%ax
80104b4f:	90                   	nop

80104b50 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	57                   	push   %edi
80104b54:	56                   	push   %esi
80104b55:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b56:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104b59:	83 ec 44             	sub    $0x44,%esp
80104b5c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104b62:	56                   	push   %esi
80104b63:	50                   	push   %eax
{
80104b64:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104b67:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104b6a:	e8 71 d3 ff ff       	call   80101ee0 <nameiparent>
80104b6f:	83 c4 10             	add    $0x10,%esp
80104b72:	85 c0                	test   %eax,%eax
80104b74:	0f 84 46 01 00 00    	je     80104cc0 <create+0x170>
    return 0;
  ilock(dp);
80104b7a:	83 ec 0c             	sub    $0xc,%esp
80104b7d:	89 c3                	mov    %eax,%ebx
80104b7f:	50                   	push   %eax
80104b80:	e8 fb ca ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b85:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b88:	83 c4 0c             	add    $0xc,%esp
80104b8b:	50                   	push   %eax
80104b8c:	56                   	push   %esi
80104b8d:	53                   	push   %ebx
80104b8e:	e8 fd cf ff ff       	call   80101b90 <dirlookup>
80104b93:	83 c4 10             	add    $0x10,%esp
80104b96:	85 c0                	test   %eax,%eax
80104b98:	89 c7                	mov    %eax,%edi
80104b9a:	74 34                	je     80104bd0 <create+0x80>
    iunlockput(dp);
80104b9c:	83 ec 0c             	sub    $0xc,%esp
80104b9f:	53                   	push   %ebx
80104ba0:	e8 4b cd ff ff       	call   801018f0 <iunlockput>
    ilock(ip);
80104ba5:	89 3c 24             	mov    %edi,(%esp)
80104ba8:	e8 d3 ca ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104bad:	83 c4 10             	add    $0x10,%esp
80104bb0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104bb5:	0f 85 95 00 00 00    	jne    80104c50 <create+0x100>
80104bbb:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104bc0:	0f 85 8a 00 00 00    	jne    80104c50 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104bc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bc9:	89 f8                	mov    %edi,%eax
80104bcb:	5b                   	pop    %ebx
80104bcc:	5e                   	pop    %esi
80104bcd:	5f                   	pop    %edi
80104bce:	5d                   	pop    %ebp
80104bcf:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104bd0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104bd4:	83 ec 08             	sub    $0x8,%esp
80104bd7:	50                   	push   %eax
80104bd8:	ff 33                	pushl  (%ebx)
80104bda:	e8 31 c9 ff ff       	call   80101510 <ialloc>
80104bdf:	83 c4 10             	add    $0x10,%esp
80104be2:	85 c0                	test   %eax,%eax
80104be4:	89 c7                	mov    %eax,%edi
80104be6:	0f 84 e8 00 00 00    	je     80104cd4 <create+0x184>
  ilock(ip);
80104bec:	83 ec 0c             	sub    $0xc,%esp
80104bef:	50                   	push   %eax
80104bf0:	e8 8b ca ff ff       	call   80101680 <ilock>
  ip->major = major;
80104bf5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104bf9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104bfd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104c01:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104c05:	b8 01 00 00 00       	mov    $0x1,%eax
80104c0a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104c0e:	89 3c 24             	mov    %edi,(%esp)
80104c11:	e8 ba c9 ff ff       	call   801015d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104c16:	83 c4 10             	add    $0x10,%esp
80104c19:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c1e:	74 50                	je     80104c70 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104c20:	83 ec 04             	sub    $0x4,%esp
80104c23:	ff 77 04             	pushl  0x4(%edi)
80104c26:	56                   	push   %esi
80104c27:	53                   	push   %ebx
80104c28:	e8 d3 d1 ff ff       	call   80101e00 <dirlink>
80104c2d:	83 c4 10             	add    $0x10,%esp
80104c30:	85 c0                	test   %eax,%eax
80104c32:	0f 88 8f 00 00 00    	js     80104cc7 <create+0x177>
  iunlockput(dp);
80104c38:	83 ec 0c             	sub    $0xc,%esp
80104c3b:	53                   	push   %ebx
80104c3c:	e8 af cc ff ff       	call   801018f0 <iunlockput>
  return ip;
80104c41:	83 c4 10             	add    $0x10,%esp
}
80104c44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c47:	89 f8                	mov    %edi,%eax
80104c49:	5b                   	pop    %ebx
80104c4a:	5e                   	pop    %esi
80104c4b:	5f                   	pop    %edi
80104c4c:	5d                   	pop    %ebp
80104c4d:	c3                   	ret    
80104c4e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104c50:	83 ec 0c             	sub    $0xc,%esp
80104c53:	57                   	push   %edi
    return 0;
80104c54:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104c56:	e8 95 cc ff ff       	call   801018f0 <iunlockput>
    return 0;
80104c5b:	83 c4 10             	add    $0x10,%esp
}
80104c5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c61:	89 f8                	mov    %edi,%eax
80104c63:	5b                   	pop    %ebx
80104c64:	5e                   	pop    %esi
80104c65:	5f                   	pop    %edi
80104c66:	5d                   	pop    %ebp
80104c67:	c3                   	ret    
80104c68:	90                   	nop
80104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104c70:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104c75:	83 ec 0c             	sub    $0xc,%esp
80104c78:	53                   	push   %ebx
80104c79:	e8 52 c9 ff ff       	call   801015d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c7e:	83 c4 0c             	add    $0xc,%esp
80104c81:	ff 77 04             	pushl  0x4(%edi)
80104c84:	68 1c 79 10 80       	push   $0x8010791c
80104c89:	57                   	push   %edi
80104c8a:	e8 71 d1 ff ff       	call   80101e00 <dirlink>
80104c8f:	83 c4 10             	add    $0x10,%esp
80104c92:	85 c0                	test   %eax,%eax
80104c94:	78 1c                	js     80104cb2 <create+0x162>
80104c96:	83 ec 04             	sub    $0x4,%esp
80104c99:	ff 73 04             	pushl  0x4(%ebx)
80104c9c:	68 1b 79 10 80       	push   $0x8010791b
80104ca1:	57                   	push   %edi
80104ca2:	e8 59 d1 ff ff       	call   80101e00 <dirlink>
80104ca7:	83 c4 10             	add    $0x10,%esp
80104caa:	85 c0                	test   %eax,%eax
80104cac:	0f 89 6e ff ff ff    	jns    80104c20 <create+0xd0>
      panic("create dots");
80104cb2:	83 ec 0c             	sub    $0xc,%esp
80104cb5:	68 0f 79 10 80       	push   $0x8010790f
80104cba:	e8 d1 b6 ff ff       	call   80100390 <panic>
80104cbf:	90                   	nop
    return 0;
80104cc0:	31 ff                	xor    %edi,%edi
80104cc2:	e9 ff fe ff ff       	jmp    80104bc6 <create+0x76>
    panic("create: dirlink");
80104cc7:	83 ec 0c             	sub    $0xc,%esp
80104cca:	68 1e 79 10 80       	push   $0x8010791e
80104ccf:	e8 bc b6 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104cd4:	83 ec 0c             	sub    $0xc,%esp
80104cd7:	68 00 79 10 80       	push   $0x80107900
80104cdc:	e8 af b6 ff ff       	call   80100390 <panic>
80104ce1:	eb 0d                	jmp    80104cf0 <argfd.constprop.0>
80104ce3:	90                   	nop
80104ce4:	90                   	nop
80104ce5:	90                   	nop
80104ce6:	90                   	nop
80104ce7:	90                   	nop
80104ce8:	90                   	nop
80104ce9:	90                   	nop
80104cea:	90                   	nop
80104ceb:	90                   	nop
80104cec:	90                   	nop
80104ced:	90                   	nop
80104cee:	90                   	nop
80104cef:	90                   	nop

80104cf0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
80104cf5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104cf7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104cfa:	89 d6                	mov    %edx,%esi
80104cfc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104cff:	50                   	push   %eax
80104d00:	6a 00                	push   $0x0
80104d02:	e8 c9 fc ff ff       	call   801049d0 <argint>
80104d07:	83 c4 10             	add    $0x10,%esp
80104d0a:	85 c0                	test   %eax,%eax
80104d0c:	78 32                	js     80104d40 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104d0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d11:	83 f8 0f             	cmp    $0xf,%eax
80104d14:	77 2a                	ja     80104d40 <argfd.constprop.0+0x50>
80104d16:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104d1d:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
80104d21:	85 c9                	test   %ecx,%ecx
80104d23:	74 1b                	je     80104d40 <argfd.constprop.0+0x50>
  if(pfd)
80104d25:	85 db                	test   %ebx,%ebx
80104d27:	74 02                	je     80104d2b <argfd.constprop.0+0x3b>
    *pfd = fd;
80104d29:	89 03                	mov    %eax,(%ebx)
    *pf = f;
80104d2b:	89 0e                	mov    %ecx,(%esi)
  return 0;
80104d2d:	31 c0                	xor    %eax,%eax
}
80104d2f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d32:	5b                   	pop    %ebx
80104d33:	5e                   	pop    %esi
80104d34:	5d                   	pop    %ebp
80104d35:	c3                   	ret    
80104d36:	8d 76 00             	lea    0x0(%esi),%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d45:	eb e8                	jmp    80104d2f <argfd.constprop.0+0x3f>
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d50 <sys_dup>:
{
80104d50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104d51:	31 c0                	xor    %eax,%eax
{
80104d53:	89 e5                	mov    %esp,%ebp
80104d55:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104d56:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104d59:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
80104d5c:	e8 8f ff ff ff       	call   80104cf0 <argfd.constprop.0>
80104d61:	85 c0                	test   %eax,%eax
80104d63:	78 3b                	js     80104da0 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80104d65:	8b 55 f4             	mov    -0xc(%ebp),%edx
    if(proc->ofile[fd] == 0){
80104d68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
80104d6e:	31 db                	xor    %ebx,%ebx
80104d70:	eb 0e                	jmp    80104d80 <sys_dup+0x30>
80104d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d78:	83 c3 01             	add    $0x1,%ebx
80104d7b:	83 fb 10             	cmp    $0x10,%ebx
80104d7e:	74 20                	je     80104da0 <sys_dup+0x50>
    if(proc->ofile[fd] == 0){
80104d80:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104d84:	85 c9                	test   %ecx,%ecx
80104d86:	75 f0                	jne    80104d78 <sys_dup+0x28>
  filedup(f);
80104d88:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80104d8b:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  filedup(f);
80104d8f:	52                   	push   %edx
80104d90:	e8 4b c0 ff ff       	call   80100de0 <filedup>
}
80104d95:	89 d8                	mov    %ebx,%eax
  return fd;
80104d97:	83 c4 10             	add    $0x10,%esp
}
80104d9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d9d:	c9                   	leave  
80104d9e:	c3                   	ret    
80104d9f:	90                   	nop
    return -1;
80104da0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104da5:	89 d8                	mov    %ebx,%eax
80104da7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104daa:	c9                   	leave  
80104dab:	c3                   	ret    
80104dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104db0 <sys_read>:
{
80104db0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104db1:	31 c0                	xor    %eax,%eax
{
80104db3:	89 e5                	mov    %esp,%ebp
80104db5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104db8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104dbb:	e8 30 ff ff ff       	call   80104cf0 <argfd.constprop.0>
80104dc0:	85 c0                	test   %eax,%eax
80104dc2:	78 4c                	js     80104e10 <sys_read+0x60>
80104dc4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104dc7:	83 ec 08             	sub    $0x8,%esp
80104dca:	50                   	push   %eax
80104dcb:	6a 02                	push   $0x2
80104dcd:	e8 fe fb ff ff       	call   801049d0 <argint>
80104dd2:	83 c4 10             	add    $0x10,%esp
80104dd5:	85 c0                	test   %eax,%eax
80104dd7:	78 37                	js     80104e10 <sys_read+0x60>
80104dd9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ddc:	83 ec 04             	sub    $0x4,%esp
80104ddf:	ff 75 f0             	pushl  -0x10(%ebp)
80104de2:	50                   	push   %eax
80104de3:	6a 01                	push   $0x1
80104de5:	e8 26 fc ff ff       	call   80104a10 <argptr>
80104dea:	83 c4 10             	add    $0x10,%esp
80104ded:	85 c0                	test   %eax,%eax
80104def:	78 1f                	js     80104e10 <sys_read+0x60>
  return fileread(f, p, n);
80104df1:	83 ec 04             	sub    $0x4,%esp
80104df4:	ff 75 f0             	pushl  -0x10(%ebp)
80104df7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dfa:	ff 75 ec             	pushl  -0x14(%ebp)
80104dfd:	e8 4e c1 ff ff       	call   80100f50 <fileread>
80104e02:	83 c4 10             	add    $0x10,%esp
}
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <sys_write>:
{
80104e20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e21:	31 c0                	xor    %eax,%eax
{
80104e23:	89 e5                	mov    %esp,%ebp
80104e25:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e2b:	e8 c0 fe ff ff       	call   80104cf0 <argfd.constprop.0>
80104e30:	85 c0                	test   %eax,%eax
80104e32:	78 4c                	js     80104e80 <sys_write+0x60>
80104e34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e37:	83 ec 08             	sub    $0x8,%esp
80104e3a:	50                   	push   %eax
80104e3b:	6a 02                	push   $0x2
80104e3d:	e8 8e fb ff ff       	call   801049d0 <argint>
80104e42:	83 c4 10             	add    $0x10,%esp
80104e45:	85 c0                	test   %eax,%eax
80104e47:	78 37                	js     80104e80 <sys_write+0x60>
80104e49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e4c:	83 ec 04             	sub    $0x4,%esp
80104e4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e52:	50                   	push   %eax
80104e53:	6a 01                	push   $0x1
80104e55:	e8 b6 fb ff ff       	call   80104a10 <argptr>
80104e5a:	83 c4 10             	add    $0x10,%esp
80104e5d:	85 c0                	test   %eax,%eax
80104e5f:	78 1f                	js     80104e80 <sys_write+0x60>
  return filewrite(f, p, n);
80104e61:	83 ec 04             	sub    $0x4,%esp
80104e64:	ff 75 f0             	pushl  -0x10(%ebp)
80104e67:	ff 75 f4             	pushl  -0xc(%ebp)
80104e6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e6d:	e8 6e c1 ff ff       	call   80100fe0 <filewrite>
80104e72:	83 c4 10             	add    $0x10,%esp
}
80104e75:	c9                   	leave  
80104e76:	c3                   	ret    
80104e77:	89 f6                	mov    %esi,%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e85:	c9                   	leave  
80104e86:	c3                   	ret    
80104e87:	89 f6                	mov    %esi,%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e90 <sys_close>:
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e96:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e99:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e9c:	e8 4f fe ff ff       	call   80104cf0 <argfd.constprop.0>
80104ea1:	85 c0                	test   %eax,%eax
80104ea3:	78 2b                	js     80104ed0 <sys_close+0x40>
  proc->ofile[fd] = 0;
80104ea5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104eab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104eae:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
80104eb1:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104eb8:	00 
  fileclose(f);
80104eb9:	ff 75 f4             	pushl  -0xc(%ebp)
80104ebc:	e8 6f bf ff ff       	call   80100e30 <fileclose>
  return 0;
80104ec1:	83 c4 10             	add    $0x10,%esp
80104ec4:	31 c0                	xor    %eax,%eax
}
80104ec6:	c9                   	leave  
80104ec7:	c3                   	ret    
80104ec8:	90                   	nop
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ed5:	c9                   	leave  
80104ed6:	c3                   	ret    
80104ed7:	89 f6                	mov    %esi,%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ee0 <sys_fstat>:
{
80104ee0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ee1:	31 c0                	xor    %eax,%eax
{
80104ee3:	89 e5                	mov    %esp,%ebp
80104ee5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ee8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104eeb:	e8 00 fe ff ff       	call   80104cf0 <argfd.constprop.0>
80104ef0:	85 c0                	test   %eax,%eax
80104ef2:	78 2c                	js     80104f20 <sys_fstat+0x40>
80104ef4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ef7:	83 ec 04             	sub    $0x4,%esp
80104efa:	6a 14                	push   $0x14
80104efc:	50                   	push   %eax
80104efd:	6a 01                	push   $0x1
80104eff:	e8 0c fb ff ff       	call   80104a10 <argptr>
80104f04:	83 c4 10             	add    $0x10,%esp
80104f07:	85 c0                	test   %eax,%eax
80104f09:	78 15                	js     80104f20 <sys_fstat+0x40>
  return filestat(f, st);
80104f0b:	83 ec 08             	sub    $0x8,%esp
80104f0e:	ff 75 f4             	pushl  -0xc(%ebp)
80104f11:	ff 75 f0             	pushl  -0x10(%ebp)
80104f14:	e8 e7 bf ff ff       	call   80100f00 <filestat>
80104f19:	83 c4 10             	add    $0x10,%esp
}
80104f1c:	c9                   	leave  
80104f1d:	c3                   	ret    
80104f1e:	66 90                	xchg   %ax,%ax
    return -1;
80104f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f25:	c9                   	leave  
80104f26:	c3                   	ret    
80104f27:	89 f6                	mov    %esi,%esi
80104f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f30 <sys_link>:
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	57                   	push   %edi
80104f34:	56                   	push   %esi
80104f35:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f36:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104f39:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f3c:	50                   	push   %eax
80104f3d:	6a 00                	push   $0x0
80104f3f:	e8 1c fb ff ff       	call   80104a60 <argstr>
80104f44:	83 c4 10             	add    $0x10,%esp
80104f47:	85 c0                	test   %eax,%eax
80104f49:	0f 88 fb 00 00 00    	js     8010504a <sys_link+0x11a>
80104f4f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f52:	83 ec 08             	sub    $0x8,%esp
80104f55:	50                   	push   %eax
80104f56:	6a 01                	push   $0x1
80104f58:	e8 03 fb ff ff       	call   80104a60 <argstr>
80104f5d:	83 c4 10             	add    $0x10,%esp
80104f60:	85 c0                	test   %eax,%eax
80104f62:	0f 88 e2 00 00 00    	js     8010504a <sys_link+0x11a>
  begin_op();
80104f68:	e8 d3 dc ff ff       	call   80102c40 <begin_op>
  if((ip = namei(old)) == 0){
80104f6d:	83 ec 0c             	sub    $0xc,%esp
80104f70:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f73:	e8 48 cf ff ff       	call   80101ec0 <namei>
80104f78:	83 c4 10             	add    $0x10,%esp
80104f7b:	85 c0                	test   %eax,%eax
80104f7d:	89 c3                	mov    %eax,%ebx
80104f7f:	0f 84 ea 00 00 00    	je     8010506f <sys_link+0x13f>
  ilock(ip);
80104f85:	83 ec 0c             	sub    $0xc,%esp
80104f88:	50                   	push   %eax
80104f89:	e8 f2 c6 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
80104f8e:	83 c4 10             	add    $0x10,%esp
80104f91:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f96:	0f 84 bb 00 00 00    	je     80105057 <sys_link+0x127>
  ip->nlink++;
80104f9c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fa1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104fa4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104fa7:	53                   	push   %ebx
80104fa8:	e8 23 c6 ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
80104fad:	89 1c 24             	mov    %ebx,(%esp)
80104fb0:	e8 ab c7 ff ff       	call   80101760 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104fb5:	58                   	pop    %eax
80104fb6:	5a                   	pop    %edx
80104fb7:	57                   	push   %edi
80104fb8:	ff 75 d0             	pushl  -0x30(%ebp)
80104fbb:	e8 20 cf ff ff       	call   80101ee0 <nameiparent>
80104fc0:	83 c4 10             	add    $0x10,%esp
80104fc3:	85 c0                	test   %eax,%eax
80104fc5:	89 c6                	mov    %eax,%esi
80104fc7:	74 5b                	je     80105024 <sys_link+0xf4>
  ilock(dp);
80104fc9:	83 ec 0c             	sub    $0xc,%esp
80104fcc:	50                   	push   %eax
80104fcd:	e8 ae c6 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fd2:	83 c4 10             	add    $0x10,%esp
80104fd5:	8b 03                	mov    (%ebx),%eax
80104fd7:	39 06                	cmp    %eax,(%esi)
80104fd9:	75 3d                	jne    80105018 <sys_link+0xe8>
80104fdb:	83 ec 04             	sub    $0x4,%esp
80104fde:	ff 73 04             	pushl  0x4(%ebx)
80104fe1:	57                   	push   %edi
80104fe2:	56                   	push   %esi
80104fe3:	e8 18 ce ff ff       	call   80101e00 <dirlink>
80104fe8:	83 c4 10             	add    $0x10,%esp
80104feb:	85 c0                	test   %eax,%eax
80104fed:	78 29                	js     80105018 <sys_link+0xe8>
  iunlockput(dp);
80104fef:	83 ec 0c             	sub    $0xc,%esp
80104ff2:	56                   	push   %esi
80104ff3:	e8 f8 c8 ff ff       	call   801018f0 <iunlockput>
  iput(ip);
80104ff8:	89 1c 24             	mov    %ebx,(%esp)
80104ffb:	e8 b0 c7 ff ff       	call   801017b0 <iput>
  end_op();
80105000:	e8 ab dc ff ff       	call   80102cb0 <end_op>
  return 0;
80105005:	83 c4 10             	add    $0x10,%esp
80105008:	31 c0                	xor    %eax,%eax
}
8010500a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010500d:	5b                   	pop    %ebx
8010500e:	5e                   	pop    %esi
8010500f:	5f                   	pop    %edi
80105010:	5d                   	pop    %ebp
80105011:	c3                   	ret    
80105012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105018:	83 ec 0c             	sub    $0xc,%esp
8010501b:	56                   	push   %esi
8010501c:	e8 cf c8 ff ff       	call   801018f0 <iunlockput>
    goto bad;
80105021:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105024:	83 ec 0c             	sub    $0xc,%esp
80105027:	53                   	push   %ebx
80105028:	e8 53 c6 ff ff       	call   80101680 <ilock>
  ip->nlink--;
8010502d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105032:	89 1c 24             	mov    %ebx,(%esp)
80105035:	e8 96 c5 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
8010503a:	89 1c 24             	mov    %ebx,(%esp)
8010503d:	e8 ae c8 ff ff       	call   801018f0 <iunlockput>
  end_op();
80105042:	e8 69 dc ff ff       	call   80102cb0 <end_op>
  return -1;
80105047:	83 c4 10             	add    $0x10,%esp
}
8010504a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010504d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105052:	5b                   	pop    %ebx
80105053:	5e                   	pop    %esi
80105054:	5f                   	pop    %edi
80105055:	5d                   	pop    %ebp
80105056:	c3                   	ret    
    iunlockput(ip);
80105057:	83 ec 0c             	sub    $0xc,%esp
8010505a:	53                   	push   %ebx
8010505b:	e8 90 c8 ff ff       	call   801018f0 <iunlockput>
    end_op();
80105060:	e8 4b dc ff ff       	call   80102cb0 <end_op>
    return -1;
80105065:	83 c4 10             	add    $0x10,%esp
80105068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010506d:	eb 9b                	jmp    8010500a <sys_link+0xda>
    end_op();
8010506f:	e8 3c dc ff ff       	call   80102cb0 <end_op>
    return -1;
80105074:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105079:	eb 8f                	jmp    8010500a <sys_link+0xda>
8010507b:	90                   	nop
8010507c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105080 <sys_unlink>:
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	57                   	push   %edi
80105084:	56                   	push   %esi
80105085:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105086:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105089:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010508c:	50                   	push   %eax
8010508d:	6a 00                	push   $0x0
8010508f:	e8 cc f9 ff ff       	call   80104a60 <argstr>
80105094:	83 c4 10             	add    $0x10,%esp
80105097:	85 c0                	test   %eax,%eax
80105099:	0f 88 77 01 00 00    	js     80105216 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010509f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801050a2:	e8 99 db ff ff       	call   80102c40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801050a7:	83 ec 08             	sub    $0x8,%esp
801050aa:	53                   	push   %ebx
801050ab:	ff 75 c0             	pushl  -0x40(%ebp)
801050ae:	e8 2d ce ff ff       	call   80101ee0 <nameiparent>
801050b3:	83 c4 10             	add    $0x10,%esp
801050b6:	85 c0                	test   %eax,%eax
801050b8:	89 c6                	mov    %eax,%esi
801050ba:	0f 84 60 01 00 00    	je     80105220 <sys_unlink+0x1a0>
  ilock(dp);
801050c0:	83 ec 0c             	sub    $0xc,%esp
801050c3:	50                   	push   %eax
801050c4:	e8 b7 c5 ff ff       	call   80101680 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801050c9:	58                   	pop    %eax
801050ca:	5a                   	pop    %edx
801050cb:	68 1c 79 10 80       	push   $0x8010791c
801050d0:	53                   	push   %ebx
801050d1:	e8 9a ca ff ff       	call   80101b70 <namecmp>
801050d6:	83 c4 10             	add    $0x10,%esp
801050d9:	85 c0                	test   %eax,%eax
801050db:	0f 84 03 01 00 00    	je     801051e4 <sys_unlink+0x164>
801050e1:	83 ec 08             	sub    $0x8,%esp
801050e4:	68 1b 79 10 80       	push   $0x8010791b
801050e9:	53                   	push   %ebx
801050ea:	e8 81 ca ff ff       	call   80101b70 <namecmp>
801050ef:	83 c4 10             	add    $0x10,%esp
801050f2:	85 c0                	test   %eax,%eax
801050f4:	0f 84 ea 00 00 00    	je     801051e4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
801050fa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050fd:	83 ec 04             	sub    $0x4,%esp
80105100:	50                   	push   %eax
80105101:	53                   	push   %ebx
80105102:	56                   	push   %esi
80105103:	e8 88 ca ff ff       	call   80101b90 <dirlookup>
80105108:	83 c4 10             	add    $0x10,%esp
8010510b:	85 c0                	test   %eax,%eax
8010510d:	89 c3                	mov    %eax,%ebx
8010510f:	0f 84 cf 00 00 00    	je     801051e4 <sys_unlink+0x164>
  ilock(ip);
80105115:	83 ec 0c             	sub    $0xc,%esp
80105118:	50                   	push   %eax
80105119:	e8 62 c5 ff ff       	call   80101680 <ilock>
  if(ip->nlink < 1)
8010511e:	83 c4 10             	add    $0x10,%esp
80105121:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105126:	0f 8e 10 01 00 00    	jle    8010523c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010512c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105131:	74 6d                	je     801051a0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105133:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105136:	83 ec 04             	sub    $0x4,%esp
80105139:	6a 10                	push   $0x10
8010513b:	6a 00                	push   $0x0
8010513d:	50                   	push   %eax
8010513e:	e8 8d f5 ff ff       	call   801046d0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105143:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105146:	6a 10                	push   $0x10
80105148:	ff 75 c4             	pushl  -0x3c(%ebp)
8010514b:	50                   	push   %eax
8010514c:	56                   	push   %esi
8010514d:	e8 ee c8 ff ff       	call   80101a40 <writei>
80105152:	83 c4 20             	add    $0x20,%esp
80105155:	83 f8 10             	cmp    $0x10,%eax
80105158:	0f 85 eb 00 00 00    	jne    80105249 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010515e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105163:	0f 84 97 00 00 00    	je     80105200 <sys_unlink+0x180>
  iunlockput(dp);
80105169:	83 ec 0c             	sub    $0xc,%esp
8010516c:	56                   	push   %esi
8010516d:	e8 7e c7 ff ff       	call   801018f0 <iunlockput>
  ip->nlink--;
80105172:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105177:	89 1c 24             	mov    %ebx,(%esp)
8010517a:	e8 51 c4 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
8010517f:	89 1c 24             	mov    %ebx,(%esp)
80105182:	e8 69 c7 ff ff       	call   801018f0 <iunlockput>
  end_op();
80105187:	e8 24 db ff ff       	call   80102cb0 <end_op>
  return 0;
8010518c:	83 c4 10             	add    $0x10,%esp
8010518f:	31 c0                	xor    %eax,%eax
}
80105191:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105194:	5b                   	pop    %ebx
80105195:	5e                   	pop    %esi
80105196:	5f                   	pop    %edi
80105197:	5d                   	pop    %ebp
80105198:	c3                   	ret    
80105199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801051a0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801051a4:	76 8d                	jbe    80105133 <sys_unlink+0xb3>
801051a6:	bf 20 00 00 00       	mov    $0x20,%edi
801051ab:	eb 0f                	jmp    801051bc <sys_unlink+0x13c>
801051ad:	8d 76 00             	lea    0x0(%esi),%esi
801051b0:	83 c7 10             	add    $0x10,%edi
801051b3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801051b6:	0f 83 77 ff ff ff    	jae    80105133 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051bc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801051bf:	6a 10                	push   $0x10
801051c1:	57                   	push   %edi
801051c2:	50                   	push   %eax
801051c3:	53                   	push   %ebx
801051c4:	e8 77 c7 ff ff       	call   80101940 <readi>
801051c9:	83 c4 10             	add    $0x10,%esp
801051cc:	83 f8 10             	cmp    $0x10,%eax
801051cf:	75 5e                	jne    8010522f <sys_unlink+0x1af>
    if(de.inum != 0)
801051d1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051d6:	74 d8                	je     801051b0 <sys_unlink+0x130>
    iunlockput(ip);
801051d8:	83 ec 0c             	sub    $0xc,%esp
801051db:	53                   	push   %ebx
801051dc:	e8 0f c7 ff ff       	call   801018f0 <iunlockput>
    goto bad;
801051e1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801051e4:	83 ec 0c             	sub    $0xc,%esp
801051e7:	56                   	push   %esi
801051e8:	e8 03 c7 ff ff       	call   801018f0 <iunlockput>
  end_op();
801051ed:	e8 be da ff ff       	call   80102cb0 <end_op>
  return -1;
801051f2:	83 c4 10             	add    $0x10,%esp
801051f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051fa:	eb 95                	jmp    80105191 <sys_unlink+0x111>
801051fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105200:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105205:	83 ec 0c             	sub    $0xc,%esp
80105208:	56                   	push   %esi
80105209:	e8 c2 c3 ff ff       	call   801015d0 <iupdate>
8010520e:	83 c4 10             	add    $0x10,%esp
80105211:	e9 53 ff ff ff       	jmp    80105169 <sys_unlink+0xe9>
    return -1;
80105216:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010521b:	e9 71 ff ff ff       	jmp    80105191 <sys_unlink+0x111>
    end_op();
80105220:	e8 8b da ff ff       	call   80102cb0 <end_op>
    return -1;
80105225:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010522a:	e9 62 ff ff ff       	jmp    80105191 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010522f:	83 ec 0c             	sub    $0xc,%esp
80105232:	68 40 79 10 80       	push   $0x80107940
80105237:	e8 54 b1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010523c:	83 ec 0c             	sub    $0xc,%esp
8010523f:	68 2e 79 10 80       	push   $0x8010792e
80105244:	e8 47 b1 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105249:	83 ec 0c             	sub    $0xc,%esp
8010524c:	68 52 79 10 80       	push   $0x80107952
80105251:	e8 3a b1 ff ff       	call   80100390 <panic>
80105256:	8d 76 00             	lea    0x0(%esi),%esi
80105259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105260 <sys_open>:

int
sys_open(void)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	57                   	push   %edi
80105264:	56                   	push   %esi
80105265:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105266:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105269:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010526c:	50                   	push   %eax
8010526d:	6a 00                	push   $0x0
8010526f:	e8 ec f7 ff ff       	call   80104a60 <argstr>
80105274:	83 c4 10             	add    $0x10,%esp
80105277:	85 c0                	test   %eax,%eax
80105279:	0f 88 1d 01 00 00    	js     8010539c <sys_open+0x13c>
8010527f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105282:	83 ec 08             	sub    $0x8,%esp
80105285:	50                   	push   %eax
80105286:	6a 01                	push   $0x1
80105288:	e8 43 f7 ff ff       	call   801049d0 <argint>
8010528d:	83 c4 10             	add    $0x10,%esp
80105290:	85 c0                	test   %eax,%eax
80105292:	0f 88 04 01 00 00    	js     8010539c <sys_open+0x13c>
    return -1;

  begin_op();
80105298:	e8 a3 d9 ff ff       	call   80102c40 <begin_op>

  if(omode & O_CREATE){
8010529d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052a1:	0f 85 a9 00 00 00    	jne    80105350 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801052a7:	83 ec 0c             	sub    $0xc,%esp
801052aa:	ff 75 e0             	pushl  -0x20(%ebp)
801052ad:	e8 0e cc ff ff       	call   80101ec0 <namei>
801052b2:	83 c4 10             	add    $0x10,%esp
801052b5:	85 c0                	test   %eax,%eax
801052b7:	89 c6                	mov    %eax,%esi
801052b9:	0f 84 b2 00 00 00    	je     80105371 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801052bf:	83 ec 0c             	sub    $0xc,%esp
801052c2:	50                   	push   %eax
801052c3:	e8 b8 c3 ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052c8:	83 c4 10             	add    $0x10,%esp
801052cb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052d0:	0f 84 aa 00 00 00    	je     80105380 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052d6:	e8 95 ba ff ff       	call   80100d70 <filealloc>
801052db:	85 c0                	test   %eax,%eax
801052dd:	89 c7                	mov    %eax,%edi
801052df:	0f 84 a6 00 00 00    	je     8010538b <sys_open+0x12b>
    if(proc->ofile[fd] == 0){
801052e5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  for(fd = 0; fd < NOFILE; fd++){
801052ec:	31 db                	xor    %ebx,%ebx
801052ee:	eb 0c                	jmp    801052fc <sys_open+0x9c>
801052f0:	83 c3 01             	add    $0x1,%ebx
801052f3:	83 fb 10             	cmp    $0x10,%ebx
801052f6:	0f 84 ac 00 00 00    	je     801053a8 <sys_open+0x148>
    if(proc->ofile[fd] == 0){
801052fc:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
80105300:	85 c0                	test   %eax,%eax
80105302:	75 ec                	jne    801052f0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105304:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80105307:	89 7c 9a 28          	mov    %edi,0x28(%edx,%ebx,4)
  iunlock(ip);
8010530b:	56                   	push   %esi
8010530c:	e8 4f c4 ff ff       	call   80101760 <iunlock>
  end_op();
80105311:	e8 9a d9 ff ff       	call   80102cb0 <end_op>

  f->type = FD_INODE;
80105316:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010531c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010531f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105322:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105325:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010532c:	89 d0                	mov    %edx,%eax
8010532e:	f7 d0                	not    %eax
80105330:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105333:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105336:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105339:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010533d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105340:	89 d8                	mov    %ebx,%eax
80105342:	5b                   	pop    %ebx
80105343:	5e                   	pop    %esi
80105344:	5f                   	pop    %edi
80105345:	5d                   	pop    %ebp
80105346:	c3                   	ret    
80105347:	89 f6                	mov    %esi,%esi
80105349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105350:	83 ec 0c             	sub    $0xc,%esp
80105353:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105356:	31 c9                	xor    %ecx,%ecx
80105358:	6a 00                	push   $0x0
8010535a:	ba 02 00 00 00       	mov    $0x2,%edx
8010535f:	e8 ec f7 ff ff       	call   80104b50 <create>
    if(ip == 0){
80105364:	83 c4 10             	add    $0x10,%esp
80105367:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105369:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010536b:	0f 85 65 ff ff ff    	jne    801052d6 <sys_open+0x76>
      end_op();
80105371:	e8 3a d9 ff ff       	call   80102cb0 <end_op>
      return -1;
80105376:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010537b:	eb c0                	jmp    8010533d <sys_open+0xdd>
8010537d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105380:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105383:	85 d2                	test   %edx,%edx
80105385:	0f 84 4b ff ff ff    	je     801052d6 <sys_open+0x76>
    iunlockput(ip);
8010538b:	83 ec 0c             	sub    $0xc,%esp
8010538e:	56                   	push   %esi
8010538f:	e8 5c c5 ff ff       	call   801018f0 <iunlockput>
    end_op();
80105394:	e8 17 d9 ff ff       	call   80102cb0 <end_op>
    return -1;
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801053a1:	eb 9a                	jmp    8010533d <sys_open+0xdd>
801053a3:	90                   	nop
801053a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801053a8:	83 ec 0c             	sub    $0xc,%esp
801053ab:	57                   	push   %edi
801053ac:	e8 7f ba ff ff       	call   80100e30 <fileclose>
801053b1:	83 c4 10             	add    $0x10,%esp
801053b4:	eb d5                	jmp    8010538b <sys_open+0x12b>
801053b6:	8d 76 00             	lea    0x0(%esi),%esi
801053b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053c0 <sys_mkdir>:

int
sys_mkdir(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053c6:	e8 75 d8 ff ff       	call   80102c40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053ce:	83 ec 08             	sub    $0x8,%esp
801053d1:	50                   	push   %eax
801053d2:	6a 00                	push   $0x0
801053d4:	e8 87 f6 ff ff       	call   80104a60 <argstr>
801053d9:	83 c4 10             	add    $0x10,%esp
801053dc:	85 c0                	test   %eax,%eax
801053de:	78 30                	js     80105410 <sys_mkdir+0x50>
801053e0:	83 ec 0c             	sub    $0xc,%esp
801053e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053e6:	31 c9                	xor    %ecx,%ecx
801053e8:	6a 00                	push   $0x0
801053ea:	ba 01 00 00 00       	mov    $0x1,%edx
801053ef:	e8 5c f7 ff ff       	call   80104b50 <create>
801053f4:	83 c4 10             	add    $0x10,%esp
801053f7:	85 c0                	test   %eax,%eax
801053f9:	74 15                	je     80105410 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053fb:	83 ec 0c             	sub    $0xc,%esp
801053fe:	50                   	push   %eax
801053ff:	e8 ec c4 ff ff       	call   801018f0 <iunlockput>
  end_op();
80105404:	e8 a7 d8 ff ff       	call   80102cb0 <end_op>
  return 0;
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	31 c0                	xor    %eax,%eax
}
8010540e:	c9                   	leave  
8010540f:	c3                   	ret    
    end_op();
80105410:	e8 9b d8 ff ff       	call   80102cb0 <end_op>
    return -1;
80105415:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010541a:	c9                   	leave  
8010541b:	c3                   	ret    
8010541c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105420 <sys_mknod>:

int
sys_mknod(void)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105426:	e8 15 d8 ff ff       	call   80102c40 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010542b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010542e:	83 ec 08             	sub    $0x8,%esp
80105431:	50                   	push   %eax
80105432:	6a 00                	push   $0x0
80105434:	e8 27 f6 ff ff       	call   80104a60 <argstr>
80105439:	83 c4 10             	add    $0x10,%esp
8010543c:	85 c0                	test   %eax,%eax
8010543e:	78 60                	js     801054a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105440:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105443:	83 ec 08             	sub    $0x8,%esp
80105446:	50                   	push   %eax
80105447:	6a 01                	push   $0x1
80105449:	e8 82 f5 ff ff       	call   801049d0 <argint>
  if((argstr(0, &path)) < 0 ||
8010544e:	83 c4 10             	add    $0x10,%esp
80105451:	85 c0                	test   %eax,%eax
80105453:	78 4b                	js     801054a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105455:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105458:	83 ec 08             	sub    $0x8,%esp
8010545b:	50                   	push   %eax
8010545c:	6a 02                	push   $0x2
8010545e:	e8 6d f5 ff ff       	call   801049d0 <argint>
     argint(1, &major) < 0 ||
80105463:	83 c4 10             	add    $0x10,%esp
80105466:	85 c0                	test   %eax,%eax
80105468:	78 36                	js     801054a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010546a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010546e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105471:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105475:	ba 03 00 00 00       	mov    $0x3,%edx
8010547a:	50                   	push   %eax
8010547b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010547e:	e8 cd f6 ff ff       	call   80104b50 <create>
80105483:	83 c4 10             	add    $0x10,%esp
80105486:	85 c0                	test   %eax,%eax
80105488:	74 16                	je     801054a0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010548a:	83 ec 0c             	sub    $0xc,%esp
8010548d:	50                   	push   %eax
8010548e:	e8 5d c4 ff ff       	call   801018f0 <iunlockput>
  end_op();
80105493:	e8 18 d8 ff ff       	call   80102cb0 <end_op>
  return 0;
80105498:	83 c4 10             	add    $0x10,%esp
8010549b:	31 c0                	xor    %eax,%eax
}
8010549d:	c9                   	leave  
8010549e:	c3                   	ret    
8010549f:	90                   	nop
    end_op();
801054a0:	e8 0b d8 ff ff       	call   80102cb0 <end_op>
    return -1;
801054a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054aa:	c9                   	leave  
801054ab:	c3                   	ret    
801054ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054b0 <sys_chdir>:

int
sys_chdir(void)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	53                   	push   %ebx
801054b4:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
801054b7:	e8 84 d7 ff ff       	call   80102c40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054bc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054bf:	83 ec 08             	sub    $0x8,%esp
801054c2:	50                   	push   %eax
801054c3:	6a 00                	push   $0x0
801054c5:	e8 96 f5 ff ff       	call   80104a60 <argstr>
801054ca:	83 c4 10             	add    $0x10,%esp
801054cd:	85 c0                	test   %eax,%eax
801054cf:	78 7f                	js     80105550 <sys_chdir+0xa0>
801054d1:	83 ec 0c             	sub    $0xc,%esp
801054d4:	ff 75 f4             	pushl  -0xc(%ebp)
801054d7:	e8 e4 c9 ff ff       	call   80101ec0 <namei>
801054dc:	83 c4 10             	add    $0x10,%esp
801054df:	85 c0                	test   %eax,%eax
801054e1:	89 c3                	mov    %eax,%ebx
801054e3:	74 6b                	je     80105550 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054e5:	83 ec 0c             	sub    $0xc,%esp
801054e8:	50                   	push   %eax
801054e9:	e8 92 c1 ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
801054ee:	83 c4 10             	add    $0x10,%esp
801054f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054f6:	75 38                	jne    80105530 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054f8:	83 ec 0c             	sub    $0xc,%esp
801054fb:	53                   	push   %ebx
801054fc:	e8 5f c2 ff ff       	call   80101760 <iunlock>
  iput(proc->cwd);
80105501:	58                   	pop    %eax
80105502:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105508:	ff 70 68             	pushl  0x68(%eax)
8010550b:	e8 a0 c2 ff ff       	call   801017b0 <iput>
  end_op();
80105510:	e8 9b d7 ff ff       	call   80102cb0 <end_op>
  proc->cwd = ip;
80105515:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
8010551b:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
8010551e:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
80105521:	31 c0                	xor    %eax,%eax
}
80105523:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105526:	c9                   	leave  
80105527:	c3                   	ret    
80105528:	90                   	nop
80105529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105530:	83 ec 0c             	sub    $0xc,%esp
80105533:	53                   	push   %ebx
80105534:	e8 b7 c3 ff ff       	call   801018f0 <iunlockput>
    end_op();
80105539:	e8 72 d7 ff ff       	call   80102cb0 <end_op>
    return -1;
8010553e:	83 c4 10             	add    $0x10,%esp
80105541:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105546:	eb db                	jmp    80105523 <sys_chdir+0x73>
80105548:	90                   	nop
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105550:	e8 5b d7 ff ff       	call   80102cb0 <end_op>
    return -1;
80105555:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010555a:	eb c7                	jmp    80105523 <sys_chdir+0x73>
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <sys_exec>:

int
sys_exec(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105566:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010556c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105572:	50                   	push   %eax
80105573:	6a 00                	push   $0x0
80105575:	e8 e6 f4 ff ff       	call   80104a60 <argstr>
8010557a:	83 c4 10             	add    $0x10,%esp
8010557d:	85 c0                	test   %eax,%eax
8010557f:	0f 88 87 00 00 00    	js     8010560c <sys_exec+0xac>
80105585:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010558b:	83 ec 08             	sub    $0x8,%esp
8010558e:	50                   	push   %eax
8010558f:	6a 01                	push   $0x1
80105591:	e8 3a f4 ff ff       	call   801049d0 <argint>
80105596:	83 c4 10             	add    $0x10,%esp
80105599:	85 c0                	test   %eax,%eax
8010559b:	78 6f                	js     8010560c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010559d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055a3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801055a6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801055a8:	68 80 00 00 00       	push   $0x80
801055ad:	6a 00                	push   $0x0
801055af:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801055b5:	50                   	push   %eax
801055b6:	e8 15 f1 ff ff       	call   801046d0 <memset>
801055bb:	83 c4 10             	add    $0x10,%esp
801055be:	eb 2c                	jmp    801055ec <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801055c0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055c6:	85 c0                	test   %eax,%eax
801055c8:	74 56                	je     80105620 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055ca:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801055d0:	83 ec 08             	sub    $0x8,%esp
801055d3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801055d6:	52                   	push   %edx
801055d7:	50                   	push   %eax
801055d8:	e8 93 f3 ff ff       	call   80104970 <fetchstr>
801055dd:	83 c4 10             	add    $0x10,%esp
801055e0:	85 c0                	test   %eax,%eax
801055e2:	78 28                	js     8010560c <sys_exec+0xac>
  for(i=0;; i++){
801055e4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801055e7:	83 fb 20             	cmp    $0x20,%ebx
801055ea:	74 20                	je     8010560c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055ec:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055f2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801055f9:	83 ec 08             	sub    $0x8,%esp
801055fc:	57                   	push   %edi
801055fd:	01 f0                	add    %esi,%eax
801055ff:	50                   	push   %eax
80105600:	e8 3b f3 ff ff       	call   80104940 <fetchint>
80105605:	83 c4 10             	add    $0x10,%esp
80105608:	85 c0                	test   %eax,%eax
8010560a:	79 b4                	jns    801055c0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010560c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010560f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105614:	5b                   	pop    %ebx
80105615:	5e                   	pop    %esi
80105616:	5f                   	pop    %edi
80105617:	5d                   	pop    %ebp
80105618:	c3                   	ret    
80105619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105620:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105626:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105629:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105630:	00 00 00 00 
  return exec(path, argv);
80105634:	50                   	push   %eax
80105635:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010563b:	e8 d0 b3 ff ff       	call   80100a10 <exec>
80105640:	83 c4 10             	add    $0x10,%esp
}
80105643:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105646:	5b                   	pop    %ebx
80105647:	5e                   	pop    %esi
80105648:	5f                   	pop    %edi
80105649:	5d                   	pop    %ebp
8010564a:	c3                   	ret    
8010564b:	90                   	nop
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105650 <sys_pipe>:

int
sys_pipe(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	57                   	push   %edi
80105654:	56                   	push   %esi
80105655:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105656:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105659:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010565c:	6a 08                	push   $0x8
8010565e:	50                   	push   %eax
8010565f:	6a 00                	push   $0x0
80105661:	e8 aa f3 ff ff       	call   80104a10 <argptr>
80105666:	83 c4 10             	add    $0x10,%esp
80105669:	85 c0                	test   %eax,%eax
8010566b:	0f 88 a4 00 00 00    	js     80105715 <sys_pipe+0xc5>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105671:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105674:	83 ec 08             	sub    $0x8,%esp
80105677:	50                   	push   %eax
80105678:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010567b:	50                   	push   %eax
8010567c:	e8 5f dd ff ff       	call   801033e0 <pipealloc>
80105681:	83 c4 10             	add    $0x10,%esp
80105684:	85 c0                	test   %eax,%eax
80105686:	0f 88 89 00 00 00    	js     80105715 <sys_pipe+0xc5>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010568c:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    if(proc->ofile[fd] == 0){
8010568f:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
80105696:	31 c0                	xor    %eax,%eax
80105698:	eb 0e                	jmp    801056a8 <sys_pipe+0x58>
8010569a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801056a0:	83 c0 01             	add    $0x1,%eax
801056a3:	83 f8 10             	cmp    $0x10,%eax
801056a6:	74 58                	je     80105700 <sys_pipe+0xb0>
    if(proc->ofile[fd] == 0){
801056a8:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
801056ac:	85 d2                	test   %edx,%edx
801056ae:	75 f0                	jne    801056a0 <sys_pipe+0x50>
801056b0:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056b3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801056b6:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
801056b8:	89 5e 28             	mov    %ebx,0x28(%esi)
801056bb:	eb 0b                	jmp    801056c8 <sys_pipe+0x78>
801056bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801056c0:	83 c2 01             	add    $0x1,%edx
801056c3:	83 fa 10             	cmp    $0x10,%edx
801056c6:	74 28                	je     801056f0 <sys_pipe+0xa0>
    if(proc->ofile[fd] == 0){
801056c8:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
801056cd:	75 f1                	jne    801056c0 <sys_pipe+0x70>
      proc->ofile[fd] = f;
801056cf:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801056d3:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801056d6:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
801056d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056db:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801056de:	31 c0                	xor    %eax,%eax
}
801056e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056e3:	5b                   	pop    %ebx
801056e4:	5e                   	pop    %esi
801056e5:	5f                   	pop    %edi
801056e6:	5d                   	pop    %ebp
801056e7:	c3                   	ret    
801056e8:	90                   	nop
801056e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd0] = 0;
801056f0:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
801056f7:	89 f6                	mov    %esi,%esi
801056f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fileclose(rf);
80105700:	83 ec 0c             	sub    $0xc,%esp
80105703:	53                   	push   %ebx
80105704:	e8 27 b7 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80105709:	58                   	pop    %eax
8010570a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010570d:	e8 1e b7 ff ff       	call   80100e30 <fileclose>
    return -1;
80105712:	83 c4 10             	add    $0x10,%esp
80105715:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010571a:	eb c4                	jmp    801056e0 <sys_pipe+0x90>
8010571c:	66 90                	xchg   %ax,%ax
8010571e:	66 90                	xchg   %ax,%ax

80105720 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105723:	5d                   	pop    %ebp
  return fork();
80105724:	e9 77 e3 ff ff       	jmp    80103aa0 <fork>
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105730 <sys_exit>:

int
sys_exit(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	83 ec 08             	sub    $0x8,%esp
  exit();
80105736:	e8 e5 e5 ff ff       	call   80103d20 <exit>
  return 0;  // not reached
}
8010573b:	31 c0                	xor    %eax,%eax
8010573d:	c9                   	leave  
8010573e:	c3                   	ret    
8010573f:	90                   	nop

80105740 <sys_wait>:

int
sys_wait(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105743:	5d                   	pop    %ebp
  return wait();
80105744:	e9 27 e8 ff ff       	jmp    80103f70 <wait>
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105750 <sys_kill>:

int
sys_kill(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105756:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105759:	50                   	push   %eax
8010575a:	6a 00                	push   $0x0
8010575c:	e8 6f f2 ff ff       	call   801049d0 <argint>
80105761:	83 c4 10             	add    $0x10,%esp
80105764:	85 c0                	test   %eax,%eax
80105766:	78 18                	js     80105780 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105768:	83 ec 0c             	sub    $0xc,%esp
8010576b:	ff 75 f4             	pushl  -0xc(%ebp)
8010576e:	e8 3d e9 ff ff       	call   801040b0 <kill>
80105773:	83 c4 10             	add    $0x10,%esp
}
80105776:	c9                   	leave  
80105777:	c3                   	ret    
80105778:	90                   	nop
80105779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105785:	c9                   	leave  
80105786:	c3                   	ret    
80105787:	89 f6                	mov    %esi,%esi
80105789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105790 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105790:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80105796:	55                   	push   %ebp
80105797:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105799:	8b 40 10             	mov    0x10(%eax),%eax
}
8010579c:	5d                   	pop    %ebp
8010579d:	c3                   	ret    
8010579e:	66 90                	xchg   %ax,%ax

801057a0 <sys_sbrk>:

int
sys_sbrk(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057a7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057aa:	50                   	push   %eax
801057ab:	6a 00                	push   $0x0
801057ad:	e8 1e f2 ff ff       	call   801049d0 <argint>
801057b2:	83 c4 10             	add    $0x10,%esp
801057b5:	85 c0                	test   %eax,%eax
801057b7:	78 27                	js     801057e0 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
801057b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
801057bf:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
801057c2:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801057c4:	ff 75 f4             	pushl  -0xc(%ebp)
801057c7:	e8 54 e2 ff ff       	call   80103a20 <growproc>
801057cc:	83 c4 10             	add    $0x10,%esp
801057cf:	85 c0                	test   %eax,%eax
801057d1:	78 0d                	js     801057e0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801057d3:	89 d8                	mov    %ebx,%eax
801057d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057d8:	c9                   	leave  
801057d9:	c3                   	ret    
801057da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801057e0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057e5:	eb ec                	jmp    801057d3 <sys_sbrk+0x33>
801057e7:	89 f6                	mov    %esi,%esi
801057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057f0 <sys_sleep>:

int
sys_sleep(void)
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057f7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057fa:	50                   	push   %eax
801057fb:	6a 00                	push   $0x0
801057fd:	e8 ce f1 ff ff       	call   801049d0 <argint>
80105802:	83 c4 10             	add    $0x10,%esp
80105805:	85 c0                	test   %eax,%eax
80105807:	0f 88 8a 00 00 00    	js     80105897 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010580d:	83 ec 0c             	sub    $0xc,%esp
80105810:	68 e0 4d 11 80       	push   $0x80114de0
80105815:	e8 a6 ec ff ff       	call   801044c0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010581a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010581d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105820:	8b 1d 20 56 11 80    	mov    0x80115620,%ebx
  while(ticks - ticks0 < n){
80105826:	85 d2                	test   %edx,%edx
80105828:	75 27                	jne    80105851 <sys_sleep+0x61>
8010582a:	eb 54                	jmp    80105880 <sys_sleep+0x90>
8010582c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105830:	83 ec 08             	sub    $0x8,%esp
80105833:	68 e0 4d 11 80       	push   $0x80114de0
80105838:	68 20 56 11 80       	push   $0x80115620
8010583d:	e8 6e e6 ff ff       	call   80103eb0 <sleep>
  while(ticks - ticks0 < n){
80105842:	a1 20 56 11 80       	mov    0x80115620,%eax
80105847:	83 c4 10             	add    $0x10,%esp
8010584a:	29 d8                	sub    %ebx,%eax
8010584c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010584f:	73 2f                	jae    80105880 <sys_sleep+0x90>
    if(proc->killed){
80105851:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105857:	8b 40 24             	mov    0x24(%eax),%eax
8010585a:	85 c0                	test   %eax,%eax
8010585c:	74 d2                	je     80105830 <sys_sleep+0x40>
      release(&tickslock);
8010585e:	83 ec 0c             	sub    $0xc,%esp
80105861:	68 e0 4d 11 80       	push   $0x80114de0
80105866:	e8 15 ee ff ff       	call   80104680 <release>
      return -1;
8010586b:	83 c4 10             	add    $0x10,%esp
8010586e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105873:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105876:	c9                   	leave  
80105877:	c3                   	ret    
80105878:	90                   	nop
80105879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80105880:	83 ec 0c             	sub    $0xc,%esp
80105883:	68 e0 4d 11 80       	push   $0x80114de0
80105888:	e8 f3 ed ff ff       	call   80104680 <release>
  return 0;
8010588d:	83 c4 10             	add    $0x10,%esp
80105890:	31 c0                	xor    %eax,%eax
}
80105892:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105895:	c9                   	leave  
80105896:	c3                   	ret    
    return -1;
80105897:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010589c:	eb f4                	jmp    80105892 <sys_sleep+0xa2>
8010589e:	66 90                	xchg   %ax,%ax

801058a0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	53                   	push   %ebx
801058a4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801058a7:	68 e0 4d 11 80       	push   $0x80114de0
801058ac:	e8 0f ec ff ff       	call   801044c0 <acquire>
  xticks = ticks;
801058b1:	8b 1d 20 56 11 80    	mov    0x80115620,%ebx
  release(&tickslock);
801058b7:	c7 04 24 e0 4d 11 80 	movl   $0x80114de0,(%esp)
801058be:	e8 bd ed ff ff       	call   80104680 <release>
  return xticks;
}
801058c3:	89 d8                	mov    %ebx,%eax
801058c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058c8:	c9                   	leave  
801058c9:	c3                   	ret    
801058ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058d0 <sys_getNumProc>:
//My Commands starts here :)
int sys_getNumProc(void){
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
	return getNumProc();
}
801058d3:	5d                   	pop    %ebp
	return getNumProc();
801058d4:	e9 17 e9 ff ff       	jmp    801041f0 <getNumProc>
801058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058e0 <sys_chpr>:

//For Priority Inversion
int sys_chpr (void){
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;
  if(argint(0, &pid) < 0)
801058e6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058e9:	50                   	push   %eax
801058ea:	6a 00                	push   $0x0
801058ec:	e8 df f0 ff ff       	call   801049d0 <argint>
801058f1:	83 c4 10             	add    $0x10,%esp
801058f4:	85 c0                	test   %eax,%eax
801058f6:	78 28                	js     80105920 <sys_chpr+0x40>
    return -1;
  if(argint(1, &pr) < 0)
801058f8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058fb:	83 ec 08             	sub    $0x8,%esp
801058fe:	50                   	push   %eax
801058ff:	6a 01                	push   $0x1
80105901:	e8 ca f0 ff ff       	call   801049d0 <argint>
80105906:	83 c4 10             	add    $0x10,%esp
80105909:	85 c0                	test   %eax,%eax
8010590b:	78 13                	js     80105920 <sys_chpr+0x40>
    return -1;
  return chpr ( pid, pr );
8010590d:	83 ec 08             	sub    $0x8,%esp
80105910:	ff 75 f4             	pushl  -0xc(%ebp)
80105913:	ff 75 f0             	pushl  -0x10(%ebp)
80105916:	e8 25 ea ff ff       	call   80104340 <chpr>
8010591b:	83 c4 10             	add    $0x10,%esp
}
8010591e:	c9                   	leave  
8010591f:	c3                   	ret    
    return -1;
80105920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105925:	c9                   	leave  
80105926:	c3                   	ret    
80105927:	66 90                	xchg   %ax,%ax
80105929:	66 90                	xchg   %ax,%ax
8010592b:	66 90                	xchg   %ax,%ax
8010592d:	66 90                	xchg   %ax,%ax
8010592f:	90                   	nop

80105930 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105930:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105931:	b8 34 00 00 00       	mov    $0x34,%eax
80105936:	ba 43 00 00 00       	mov    $0x43,%edx
8010593b:	89 e5                	mov    %esp,%ebp
8010593d:	83 ec 14             	sub    $0x14,%esp
80105940:	ee                   	out    %al,(%dx)
80105941:	ba 40 00 00 00       	mov    $0x40,%edx
80105946:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
8010594b:	ee                   	out    %al,(%dx)
8010594c:	b8 2e 00 00 00       	mov    $0x2e,%eax
80105951:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
80105952:	6a 00                	push   $0x0
80105954:	e8 b7 d9 ff ff       	call   80103310 <picenable>
}
80105959:	83 c4 10             	add    $0x10,%esp
8010595c:	c9                   	leave  
8010595d:	c3                   	ret    

8010595e <alltraps>:
8010595e:	1e                   	push   %ds
8010595f:	06                   	push   %es
80105960:	0f a0                	push   %fs
80105962:	0f a8                	push   %gs
80105964:	60                   	pusha  
80105965:	66 b8 10 00          	mov    $0x10,%ax
80105969:	8e d8                	mov    %eax,%ds
8010596b:	8e c0                	mov    %eax,%es
8010596d:	66 b8 18 00          	mov    $0x18,%ax
80105971:	8e e0                	mov    %eax,%fs
80105973:	8e e8                	mov    %eax,%gs
80105975:	54                   	push   %esp
80105976:	e8 c5 00 00 00       	call   80105a40 <trap>
8010597b:	83 c4 04             	add    $0x4,%esp

8010597e <trapret>:
8010597e:	61                   	popa   
8010597f:	0f a9                	pop    %gs
80105981:	0f a1                	pop    %fs
80105983:	07                   	pop    %es
80105984:	1f                   	pop    %ds
80105985:	83 c4 08             	add    $0x8,%esp
80105988:	cf                   	iret   
80105989:	66 90                	xchg   %ax,%ax
8010598b:	66 90                	xchg   %ax,%ax
8010598d:	66 90                	xchg   %ax,%ax
8010598f:	90                   	nop

80105990 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105990:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105991:	31 c0                	xor    %eax,%eax
{
80105993:	89 e5                	mov    %esp,%ebp
80105995:	83 ec 08             	sub    $0x8,%esp
80105998:	90                   	nop
80105999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801059a0:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
801059a7:	c7 04 c5 22 4e 11 80 	movl   $0x8e000008,-0x7feeb1de(,%eax,8)
801059ae:	08 00 00 8e 
801059b2:	66 89 14 c5 20 4e 11 	mov    %dx,-0x7feeb1e0(,%eax,8)
801059b9:	80 
801059ba:	c1 ea 10             	shr    $0x10,%edx
801059bd:	66 89 14 c5 26 4e 11 	mov    %dx,-0x7feeb1da(,%eax,8)
801059c4:	80 
  for(i = 0; i < 256; i++)
801059c5:	83 c0 01             	add    $0x1,%eax
801059c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801059cd:	75 d1                	jne    801059a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059cf:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
801059d4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059d7:	c7 05 22 50 11 80 08 	movl   $0xef000008,0x80115022
801059de:	00 00 ef 
  initlock(&tickslock, "time");
801059e1:	68 61 79 10 80       	push   $0x80107961
801059e6:	68 e0 4d 11 80       	push   $0x80114de0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059eb:	66 a3 20 50 11 80    	mov    %ax,0x80115020
801059f1:	c1 e8 10             	shr    $0x10,%eax
801059f4:	66 a3 26 50 11 80    	mov    %ax,0x80115026
  initlock(&tickslock, "time");
801059fa:	e8 a1 ea ff ff       	call   801044a0 <initlock>
}
801059ff:	83 c4 10             	add    $0x10,%esp
80105a02:	c9                   	leave  
80105a03:	c3                   	ret    
80105a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105a10 <idtinit>:

void
idtinit(void)
{
80105a10:	55                   	push   %ebp
  pd[0] = size-1;
80105a11:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a16:	89 e5                	mov    %esp,%ebp
80105a18:	83 ec 10             	sub    $0x10,%esp
80105a1b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a1f:	b8 20 4e 11 80       	mov    $0x80114e20,%eax
80105a24:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a28:	c1 e8 10             	shr    $0x10,%eax
80105a2b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105a2f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a32:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a35:	c9                   	leave  
80105a36:	c3                   	ret    
80105a37:	89 f6                	mov    %esi,%esi
80105a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a40 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	57                   	push   %edi
80105a44:	56                   	push   %esi
80105a45:	53                   	push   %ebx
80105a46:	83 ec 0c             	sub    $0xc,%esp
80105a49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105a4c:	8b 43 30             	mov    0x30(%ebx),%eax
80105a4f:	83 f8 40             	cmp    $0x40,%eax
80105a52:	74 6c                	je     80105ac0 <trap+0x80>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a54:	83 e8 20             	sub    $0x20,%eax
80105a57:	83 f8 1f             	cmp    $0x1f,%eax
80105a5a:	0f 87 98 00 00 00    	ja     80105af8 <trap+0xb8>
80105a60:	ff 24 85 08 7a 10 80 	jmp    *-0x7fef85f8(,%eax,4)
80105a67:	89 f6                	mov    %esi,%esi
80105a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105a70:	e8 cb cc ff ff       	call   80102740 <cpunum>
80105a75:	85 c0                	test   %eax,%eax
80105a77:	0f 84 a3 01 00 00    	je     80105c20 <trap+0x1e0>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105a7d:	e8 6e cd ff ff       	call   801027f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105a82:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a88:	85 c0                	test   %eax,%eax
80105a8a:	74 29                	je     80105ab5 <trap+0x75>
80105a8c:	8b 50 24             	mov    0x24(%eax),%edx
80105a8f:	85 d2                	test   %edx,%edx
80105a91:	0f 85 b6 00 00 00    	jne    80105b4d <trap+0x10d>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105a97:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a9b:	0f 84 3f 01 00 00    	je     80105be0 <trap+0x1a0>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105aa1:	8b 40 24             	mov    0x24(%eax),%eax
80105aa4:	85 c0                	test   %eax,%eax
80105aa6:	74 0d                	je     80105ab5 <trap+0x75>
80105aa8:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105aac:	83 e0 03             	and    $0x3,%eax
80105aaf:	66 83 f8 03          	cmp    $0x3,%ax
80105ab3:	74 31                	je     80105ae6 <trap+0xa6>
    exit();
}
80105ab5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ab8:	5b                   	pop    %ebx
80105ab9:	5e                   	pop    %esi
80105aba:	5f                   	pop    %edi
80105abb:	5d                   	pop    %ebp
80105abc:	c3                   	ret    
80105abd:	8d 76 00             	lea    0x0(%esi),%esi
    if(proc->killed)
80105ac0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ac6:	8b 70 24             	mov    0x24(%eax),%esi
80105ac9:	85 f6                	test   %esi,%esi
80105acb:	0f 85 37 01 00 00    	jne    80105c08 <trap+0x1c8>
    proc->tf = tf;
80105ad1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105ad4:	e8 07 f0 ff ff       	call   80104ae0 <syscall>
    if(proc->killed)
80105ad9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105adf:	8b 58 24             	mov    0x24(%eax),%ebx
80105ae2:	85 db                	test   %ebx,%ebx
80105ae4:	74 cf                	je     80105ab5 <trap+0x75>
}
80105ae6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ae9:	5b                   	pop    %ebx
80105aea:	5e                   	pop    %esi
80105aeb:	5f                   	pop    %edi
80105aec:	5d                   	pop    %ebp
      exit();
80105aed:	e9 2e e2 ff ff       	jmp    80103d20 <exit>
80105af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc == 0 || (tf->cs&3) == 0){
80105af8:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105aff:	8b 73 38             	mov    0x38(%ebx),%esi
80105b02:	85 c9                	test   %ecx,%ecx
80105b04:	0f 84 4a 01 00 00    	je     80105c54 <trap+0x214>
80105b0a:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105b0e:	0f 84 40 01 00 00    	je     80105c54 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105b14:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b17:	e8 24 cc ff ff       	call   80102740 <cpunum>
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105b1c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b23:	57                   	push   %edi
80105b24:	56                   	push   %esi
80105b25:	50                   	push   %eax
80105b26:	ff 73 34             	pushl  0x34(%ebx)
80105b29:	ff 73 30             	pushl  0x30(%ebx)
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105b2c:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b2f:	50                   	push   %eax
80105b30:	ff 72 10             	pushl  0x10(%edx)
80105b33:	68 c4 79 10 80       	push   $0x801079c4
80105b38:	e8 23 ab ff ff       	call   80100660 <cprintf>
    proc->killed = 1;
80105b3d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b43:	83 c4 20             	add    $0x20,%esp
80105b46:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b4d:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105b51:	83 e2 03             	and    $0x3,%edx
80105b54:	66 83 fa 03          	cmp    $0x3,%dx
80105b58:	0f 85 39 ff ff ff    	jne    80105a97 <trap+0x57>
    exit();
80105b5e:	e8 bd e1 ff ff       	call   80103d20 <exit>
80105b63:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105b69:	85 c0                	test   %eax,%eax
80105b6b:	0f 85 26 ff ff ff    	jne    80105a97 <trap+0x57>
80105b71:	e9 3f ff ff ff       	jmp    80105ab5 <trap+0x75>
80105b76:	8d 76 00             	lea    0x0(%esi),%esi
80105b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80105b80:	e8 9b ca ff ff       	call   80102620 <kbdintr>
    lapiceoi();
80105b85:	e8 66 cc ff ff       	call   801027f0 <lapiceoi>
    break;
80105b8a:	e9 f3 fe ff ff       	jmp    80105a82 <trap+0x42>
80105b8f:	90                   	nop
    uartintr();
80105b90:	e8 5b 02 00 00       	call   80105df0 <uartintr>
80105b95:	e9 e3 fe ff ff       	jmp    80105a7d <trap+0x3d>
80105b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ba0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105ba4:	8b 7b 38             	mov    0x38(%ebx),%edi
80105ba7:	e8 94 cb ff ff       	call   80102740 <cpunum>
80105bac:	57                   	push   %edi
80105bad:	56                   	push   %esi
80105bae:	50                   	push   %eax
80105baf:	68 6c 79 10 80       	push   $0x8010796c
80105bb4:	e8 a7 aa ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105bb9:	e8 32 cc ff ff       	call   801027f0 <lapiceoi>
    break;
80105bbe:	83 c4 10             	add    $0x10,%esp
80105bc1:	e9 bc fe ff ff       	jmp    80105a82 <trap+0x42>
80105bc6:	8d 76 00             	lea    0x0(%esi),%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80105bd0:	e8 9b c4 ff ff       	call   80102070 <ideintr>
    lapiceoi();
80105bd5:	e8 16 cc ff ff       	call   801027f0 <lapiceoi>
    break;
80105bda:	e9 a3 fe ff ff       	jmp    80105a82 <trap+0x42>
80105bdf:	90                   	nop
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105be0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105be4:	0f 85 b7 fe ff ff    	jne    80105aa1 <trap+0x61>
    yield();
80105bea:	e8 81 e2 ff ff       	call   80103e70 <yield>
80105bef:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105bf5:	85 c0                	test   %eax,%eax
80105bf7:	0f 85 a4 fe ff ff    	jne    80105aa1 <trap+0x61>
80105bfd:	e9 b3 fe ff ff       	jmp    80105ab5 <trap+0x75>
80105c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105c08:	e8 13 e1 ff ff       	call   80103d20 <exit>
80105c0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c13:	e9 b9 fe ff ff       	jmp    80105ad1 <trap+0x91>
80105c18:	90                   	nop
80105c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80105c20:	83 ec 0c             	sub    $0xc,%esp
80105c23:	68 e0 4d 11 80       	push   $0x80114de0
80105c28:	e8 93 e8 ff ff       	call   801044c0 <acquire>
      wakeup(&ticks);
80105c2d:	c7 04 24 20 56 11 80 	movl   $0x80115620,(%esp)
      ticks++;
80105c34:	83 05 20 56 11 80 01 	addl   $0x1,0x80115620
      wakeup(&ticks);
80105c3b:	e8 10 e4 ff ff       	call   80104050 <wakeup>
      release(&tickslock);
80105c40:	c7 04 24 e0 4d 11 80 	movl   $0x80114de0,(%esp)
80105c47:	e8 34 ea ff ff       	call   80104680 <release>
80105c4c:	83 c4 10             	add    $0x10,%esp
80105c4f:	e9 29 fe ff ff       	jmp    80105a7d <trap+0x3d>
80105c54:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c57:	e8 e4 ca ff ff       	call   80102740 <cpunum>
80105c5c:	83 ec 0c             	sub    $0xc,%esp
80105c5f:	57                   	push   %edi
80105c60:	56                   	push   %esi
80105c61:	50                   	push   %eax
80105c62:	ff 73 30             	pushl  0x30(%ebx)
80105c65:	68 90 79 10 80       	push   $0x80107990
80105c6a:	e8 f1 a9 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105c6f:	83 c4 14             	add    $0x14,%esp
80105c72:	68 66 79 10 80       	push   $0x80107966
80105c77:	e8 14 a7 ff ff       	call   80100390 <panic>
80105c7c:	66 90                	xchg   %ax,%ax
80105c7e:	66 90                	xchg   %ax,%ax

80105c80 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c80:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
{
80105c85:	55                   	push   %ebp
80105c86:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c88:	85 c0                	test   %eax,%eax
80105c8a:	74 1c                	je     80105ca8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c8c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c91:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c92:	a8 01                	test   $0x1,%al
80105c94:	74 12                	je     80105ca8 <uartgetc+0x28>
80105c96:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c9b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c9c:	0f b6 c0             	movzbl %al,%eax
}
80105c9f:	5d                   	pop    %ebp
80105ca0:	c3                   	ret    
80105ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cad:	5d                   	pop    %ebp
80105cae:	c3                   	ret    
80105caf:	90                   	nop

80105cb0 <uartputc.part.0>:
uartputc(int c)
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	57                   	push   %edi
80105cb4:	56                   	push   %esi
80105cb5:	53                   	push   %ebx
80105cb6:	89 c7                	mov    %eax,%edi
80105cb8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105cbd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105cc2:	83 ec 0c             	sub    $0xc,%esp
80105cc5:	eb 1b                	jmp    80105ce2 <uartputc.part.0+0x32>
80105cc7:	89 f6                	mov    %esi,%esi
80105cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105cd0:	83 ec 0c             	sub    $0xc,%esp
80105cd3:	6a 0a                	push   $0xa
80105cd5:	e8 36 cb ff ff       	call   80102810 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105cda:	83 c4 10             	add    $0x10,%esp
80105cdd:	83 eb 01             	sub    $0x1,%ebx
80105ce0:	74 07                	je     80105ce9 <uartputc.part.0+0x39>
80105ce2:	89 f2                	mov    %esi,%edx
80105ce4:	ec                   	in     (%dx),%al
80105ce5:	a8 20                	test   $0x20,%al
80105ce7:	74 e7                	je     80105cd0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ce9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cee:	89 f8                	mov    %edi,%eax
80105cf0:	ee                   	out    %al,(%dx)
}
80105cf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cf4:	5b                   	pop    %ebx
80105cf5:	5e                   	pop    %esi
80105cf6:	5f                   	pop    %edi
80105cf7:	5d                   	pop    %ebp
80105cf8:	c3                   	ret    
80105cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d00 <uartinit>:
{
80105d00:	55                   	push   %ebp
80105d01:	31 c9                	xor    %ecx,%ecx
80105d03:	89 c8                	mov    %ecx,%eax
80105d05:	89 e5                	mov    %esp,%ebp
80105d07:	57                   	push   %edi
80105d08:	56                   	push   %esi
80105d09:	53                   	push   %ebx
80105d0a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d0f:	89 da                	mov    %ebx,%edx
80105d11:	83 ec 0c             	sub    $0xc,%esp
80105d14:	ee                   	out    %al,(%dx)
80105d15:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d1a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d1f:	89 fa                	mov    %edi,%edx
80105d21:	ee                   	out    %al,(%dx)
80105d22:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d27:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d2c:	ee                   	out    %al,(%dx)
80105d2d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d32:	89 c8                	mov    %ecx,%eax
80105d34:	89 f2                	mov    %esi,%edx
80105d36:	ee                   	out    %al,(%dx)
80105d37:	b8 03 00 00 00       	mov    $0x3,%eax
80105d3c:	89 fa                	mov    %edi,%edx
80105d3e:	ee                   	out    %al,(%dx)
80105d3f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d44:	89 c8                	mov    %ecx,%eax
80105d46:	ee                   	out    %al,(%dx)
80105d47:	b8 01 00 00 00       	mov    $0x1,%eax
80105d4c:	89 f2                	mov    %esi,%edx
80105d4e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d4f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d54:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105d55:	3c ff                	cmp    $0xff,%al
80105d57:	74 5a                	je     80105db3 <uartinit+0xb3>
  uart = 1;
80105d59:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105d60:	00 00 00 
80105d63:	89 da                	mov    %ebx,%edx
80105d65:	ec                   	in     (%dx),%al
80105d66:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d6b:	ec                   	in     (%dx),%al
  picenable(IRQ_COM1);
80105d6c:	83 ec 0c             	sub    $0xc,%esp
80105d6f:	6a 04                	push   $0x4
80105d71:	e8 9a d5 ff ff       	call   80103310 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105d76:	59                   	pop    %ecx
80105d77:	5b                   	pop    %ebx
80105d78:	6a 00                	push   $0x0
80105d7a:	6a 04                	push   $0x4
  for(p="xv6...\n"; *p; p++)
80105d7c:	bb 88 7a 10 80       	mov    $0x80107a88,%ebx
  ioapicenable(IRQ_COM1, 0);
80105d81:	e8 5a c5 ff ff       	call   801022e0 <ioapicenable>
80105d86:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105d89:	b8 78 00 00 00       	mov    $0x78,%eax
80105d8e:	eb 0a                	jmp    80105d9a <uartinit+0x9a>
80105d90:	83 c3 01             	add    $0x1,%ebx
80105d93:	0f be 03             	movsbl (%ebx),%eax
80105d96:	84 c0                	test   %al,%al
80105d98:	74 19                	je     80105db3 <uartinit+0xb3>
  if(!uart)
80105d9a:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80105da0:	85 d2                	test   %edx,%edx
80105da2:	74 ec                	je     80105d90 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105da4:	83 c3 01             	add    $0x1,%ebx
80105da7:	e8 04 ff ff ff       	call   80105cb0 <uartputc.part.0>
80105dac:	0f be 03             	movsbl (%ebx),%eax
80105daf:	84 c0                	test   %al,%al
80105db1:	75 e7                	jne    80105d9a <uartinit+0x9a>
}
80105db3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105db6:	5b                   	pop    %ebx
80105db7:	5e                   	pop    %esi
80105db8:	5f                   	pop    %edi
80105db9:	5d                   	pop    %ebp
80105dba:	c3                   	ret    
80105dbb:	90                   	nop
80105dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105dc0 <uartputc>:
  if(!uart)
80105dc0:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
{
80105dc6:	55                   	push   %ebp
80105dc7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105dc9:	85 d2                	test   %edx,%edx
{
80105dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105dce:	74 10                	je     80105de0 <uartputc+0x20>
}
80105dd0:	5d                   	pop    %ebp
80105dd1:	e9 da fe ff ff       	jmp    80105cb0 <uartputc.part.0>
80105dd6:	8d 76 00             	lea    0x0(%esi),%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105de0:	5d                   	pop    %ebp
80105de1:	c3                   	ret    
80105de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105df0 <uartintr>:

void
uartintr(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105df6:	68 80 5c 10 80       	push   $0x80105c80
80105dfb:	e8 10 aa ff ff       	call   80100810 <consoleintr>
}
80105e00:	83 c4 10             	add    $0x10,%esp
80105e03:	c9                   	leave  
80105e04:	c3                   	ret    

80105e05 <vector0>:
80105e05:	6a 00                	push   $0x0
80105e07:	6a 00                	push   $0x0
80105e09:	e9 50 fb ff ff       	jmp    8010595e <alltraps>

80105e0e <vector1>:
80105e0e:	6a 00                	push   $0x0
80105e10:	6a 01                	push   $0x1
80105e12:	e9 47 fb ff ff       	jmp    8010595e <alltraps>

80105e17 <vector2>:
80105e17:	6a 00                	push   $0x0
80105e19:	6a 02                	push   $0x2
80105e1b:	e9 3e fb ff ff       	jmp    8010595e <alltraps>

80105e20 <vector3>:
80105e20:	6a 00                	push   $0x0
80105e22:	6a 03                	push   $0x3
80105e24:	e9 35 fb ff ff       	jmp    8010595e <alltraps>

80105e29 <vector4>:
80105e29:	6a 00                	push   $0x0
80105e2b:	6a 04                	push   $0x4
80105e2d:	e9 2c fb ff ff       	jmp    8010595e <alltraps>

80105e32 <vector5>:
80105e32:	6a 00                	push   $0x0
80105e34:	6a 05                	push   $0x5
80105e36:	e9 23 fb ff ff       	jmp    8010595e <alltraps>

80105e3b <vector6>:
80105e3b:	6a 00                	push   $0x0
80105e3d:	6a 06                	push   $0x6
80105e3f:	e9 1a fb ff ff       	jmp    8010595e <alltraps>

80105e44 <vector7>:
80105e44:	6a 00                	push   $0x0
80105e46:	6a 07                	push   $0x7
80105e48:	e9 11 fb ff ff       	jmp    8010595e <alltraps>

80105e4d <vector8>:
80105e4d:	6a 08                	push   $0x8
80105e4f:	e9 0a fb ff ff       	jmp    8010595e <alltraps>

80105e54 <vector9>:
80105e54:	6a 00                	push   $0x0
80105e56:	6a 09                	push   $0x9
80105e58:	e9 01 fb ff ff       	jmp    8010595e <alltraps>

80105e5d <vector10>:
80105e5d:	6a 0a                	push   $0xa
80105e5f:	e9 fa fa ff ff       	jmp    8010595e <alltraps>

80105e64 <vector11>:
80105e64:	6a 0b                	push   $0xb
80105e66:	e9 f3 fa ff ff       	jmp    8010595e <alltraps>

80105e6b <vector12>:
80105e6b:	6a 0c                	push   $0xc
80105e6d:	e9 ec fa ff ff       	jmp    8010595e <alltraps>

80105e72 <vector13>:
80105e72:	6a 0d                	push   $0xd
80105e74:	e9 e5 fa ff ff       	jmp    8010595e <alltraps>

80105e79 <vector14>:
80105e79:	6a 0e                	push   $0xe
80105e7b:	e9 de fa ff ff       	jmp    8010595e <alltraps>

80105e80 <vector15>:
80105e80:	6a 00                	push   $0x0
80105e82:	6a 0f                	push   $0xf
80105e84:	e9 d5 fa ff ff       	jmp    8010595e <alltraps>

80105e89 <vector16>:
80105e89:	6a 00                	push   $0x0
80105e8b:	6a 10                	push   $0x10
80105e8d:	e9 cc fa ff ff       	jmp    8010595e <alltraps>

80105e92 <vector17>:
80105e92:	6a 11                	push   $0x11
80105e94:	e9 c5 fa ff ff       	jmp    8010595e <alltraps>

80105e99 <vector18>:
80105e99:	6a 00                	push   $0x0
80105e9b:	6a 12                	push   $0x12
80105e9d:	e9 bc fa ff ff       	jmp    8010595e <alltraps>

80105ea2 <vector19>:
80105ea2:	6a 00                	push   $0x0
80105ea4:	6a 13                	push   $0x13
80105ea6:	e9 b3 fa ff ff       	jmp    8010595e <alltraps>

80105eab <vector20>:
80105eab:	6a 00                	push   $0x0
80105ead:	6a 14                	push   $0x14
80105eaf:	e9 aa fa ff ff       	jmp    8010595e <alltraps>

80105eb4 <vector21>:
80105eb4:	6a 00                	push   $0x0
80105eb6:	6a 15                	push   $0x15
80105eb8:	e9 a1 fa ff ff       	jmp    8010595e <alltraps>

80105ebd <vector22>:
80105ebd:	6a 00                	push   $0x0
80105ebf:	6a 16                	push   $0x16
80105ec1:	e9 98 fa ff ff       	jmp    8010595e <alltraps>

80105ec6 <vector23>:
80105ec6:	6a 00                	push   $0x0
80105ec8:	6a 17                	push   $0x17
80105eca:	e9 8f fa ff ff       	jmp    8010595e <alltraps>

80105ecf <vector24>:
80105ecf:	6a 00                	push   $0x0
80105ed1:	6a 18                	push   $0x18
80105ed3:	e9 86 fa ff ff       	jmp    8010595e <alltraps>

80105ed8 <vector25>:
80105ed8:	6a 00                	push   $0x0
80105eda:	6a 19                	push   $0x19
80105edc:	e9 7d fa ff ff       	jmp    8010595e <alltraps>

80105ee1 <vector26>:
80105ee1:	6a 00                	push   $0x0
80105ee3:	6a 1a                	push   $0x1a
80105ee5:	e9 74 fa ff ff       	jmp    8010595e <alltraps>

80105eea <vector27>:
80105eea:	6a 00                	push   $0x0
80105eec:	6a 1b                	push   $0x1b
80105eee:	e9 6b fa ff ff       	jmp    8010595e <alltraps>

80105ef3 <vector28>:
80105ef3:	6a 00                	push   $0x0
80105ef5:	6a 1c                	push   $0x1c
80105ef7:	e9 62 fa ff ff       	jmp    8010595e <alltraps>

80105efc <vector29>:
80105efc:	6a 00                	push   $0x0
80105efe:	6a 1d                	push   $0x1d
80105f00:	e9 59 fa ff ff       	jmp    8010595e <alltraps>

80105f05 <vector30>:
80105f05:	6a 00                	push   $0x0
80105f07:	6a 1e                	push   $0x1e
80105f09:	e9 50 fa ff ff       	jmp    8010595e <alltraps>

80105f0e <vector31>:
80105f0e:	6a 00                	push   $0x0
80105f10:	6a 1f                	push   $0x1f
80105f12:	e9 47 fa ff ff       	jmp    8010595e <alltraps>

80105f17 <vector32>:
80105f17:	6a 00                	push   $0x0
80105f19:	6a 20                	push   $0x20
80105f1b:	e9 3e fa ff ff       	jmp    8010595e <alltraps>

80105f20 <vector33>:
80105f20:	6a 00                	push   $0x0
80105f22:	6a 21                	push   $0x21
80105f24:	e9 35 fa ff ff       	jmp    8010595e <alltraps>

80105f29 <vector34>:
80105f29:	6a 00                	push   $0x0
80105f2b:	6a 22                	push   $0x22
80105f2d:	e9 2c fa ff ff       	jmp    8010595e <alltraps>

80105f32 <vector35>:
80105f32:	6a 00                	push   $0x0
80105f34:	6a 23                	push   $0x23
80105f36:	e9 23 fa ff ff       	jmp    8010595e <alltraps>

80105f3b <vector36>:
80105f3b:	6a 00                	push   $0x0
80105f3d:	6a 24                	push   $0x24
80105f3f:	e9 1a fa ff ff       	jmp    8010595e <alltraps>

80105f44 <vector37>:
80105f44:	6a 00                	push   $0x0
80105f46:	6a 25                	push   $0x25
80105f48:	e9 11 fa ff ff       	jmp    8010595e <alltraps>

80105f4d <vector38>:
80105f4d:	6a 00                	push   $0x0
80105f4f:	6a 26                	push   $0x26
80105f51:	e9 08 fa ff ff       	jmp    8010595e <alltraps>

80105f56 <vector39>:
80105f56:	6a 00                	push   $0x0
80105f58:	6a 27                	push   $0x27
80105f5a:	e9 ff f9 ff ff       	jmp    8010595e <alltraps>

80105f5f <vector40>:
80105f5f:	6a 00                	push   $0x0
80105f61:	6a 28                	push   $0x28
80105f63:	e9 f6 f9 ff ff       	jmp    8010595e <alltraps>

80105f68 <vector41>:
80105f68:	6a 00                	push   $0x0
80105f6a:	6a 29                	push   $0x29
80105f6c:	e9 ed f9 ff ff       	jmp    8010595e <alltraps>

80105f71 <vector42>:
80105f71:	6a 00                	push   $0x0
80105f73:	6a 2a                	push   $0x2a
80105f75:	e9 e4 f9 ff ff       	jmp    8010595e <alltraps>

80105f7a <vector43>:
80105f7a:	6a 00                	push   $0x0
80105f7c:	6a 2b                	push   $0x2b
80105f7e:	e9 db f9 ff ff       	jmp    8010595e <alltraps>

80105f83 <vector44>:
80105f83:	6a 00                	push   $0x0
80105f85:	6a 2c                	push   $0x2c
80105f87:	e9 d2 f9 ff ff       	jmp    8010595e <alltraps>

80105f8c <vector45>:
80105f8c:	6a 00                	push   $0x0
80105f8e:	6a 2d                	push   $0x2d
80105f90:	e9 c9 f9 ff ff       	jmp    8010595e <alltraps>

80105f95 <vector46>:
80105f95:	6a 00                	push   $0x0
80105f97:	6a 2e                	push   $0x2e
80105f99:	e9 c0 f9 ff ff       	jmp    8010595e <alltraps>

80105f9e <vector47>:
80105f9e:	6a 00                	push   $0x0
80105fa0:	6a 2f                	push   $0x2f
80105fa2:	e9 b7 f9 ff ff       	jmp    8010595e <alltraps>

80105fa7 <vector48>:
80105fa7:	6a 00                	push   $0x0
80105fa9:	6a 30                	push   $0x30
80105fab:	e9 ae f9 ff ff       	jmp    8010595e <alltraps>

80105fb0 <vector49>:
80105fb0:	6a 00                	push   $0x0
80105fb2:	6a 31                	push   $0x31
80105fb4:	e9 a5 f9 ff ff       	jmp    8010595e <alltraps>

80105fb9 <vector50>:
80105fb9:	6a 00                	push   $0x0
80105fbb:	6a 32                	push   $0x32
80105fbd:	e9 9c f9 ff ff       	jmp    8010595e <alltraps>

80105fc2 <vector51>:
80105fc2:	6a 00                	push   $0x0
80105fc4:	6a 33                	push   $0x33
80105fc6:	e9 93 f9 ff ff       	jmp    8010595e <alltraps>

80105fcb <vector52>:
80105fcb:	6a 00                	push   $0x0
80105fcd:	6a 34                	push   $0x34
80105fcf:	e9 8a f9 ff ff       	jmp    8010595e <alltraps>

80105fd4 <vector53>:
80105fd4:	6a 00                	push   $0x0
80105fd6:	6a 35                	push   $0x35
80105fd8:	e9 81 f9 ff ff       	jmp    8010595e <alltraps>

80105fdd <vector54>:
80105fdd:	6a 00                	push   $0x0
80105fdf:	6a 36                	push   $0x36
80105fe1:	e9 78 f9 ff ff       	jmp    8010595e <alltraps>

80105fe6 <vector55>:
80105fe6:	6a 00                	push   $0x0
80105fe8:	6a 37                	push   $0x37
80105fea:	e9 6f f9 ff ff       	jmp    8010595e <alltraps>

80105fef <vector56>:
80105fef:	6a 00                	push   $0x0
80105ff1:	6a 38                	push   $0x38
80105ff3:	e9 66 f9 ff ff       	jmp    8010595e <alltraps>

80105ff8 <vector57>:
80105ff8:	6a 00                	push   $0x0
80105ffa:	6a 39                	push   $0x39
80105ffc:	e9 5d f9 ff ff       	jmp    8010595e <alltraps>

80106001 <vector58>:
80106001:	6a 00                	push   $0x0
80106003:	6a 3a                	push   $0x3a
80106005:	e9 54 f9 ff ff       	jmp    8010595e <alltraps>

8010600a <vector59>:
8010600a:	6a 00                	push   $0x0
8010600c:	6a 3b                	push   $0x3b
8010600e:	e9 4b f9 ff ff       	jmp    8010595e <alltraps>

80106013 <vector60>:
80106013:	6a 00                	push   $0x0
80106015:	6a 3c                	push   $0x3c
80106017:	e9 42 f9 ff ff       	jmp    8010595e <alltraps>

8010601c <vector61>:
8010601c:	6a 00                	push   $0x0
8010601e:	6a 3d                	push   $0x3d
80106020:	e9 39 f9 ff ff       	jmp    8010595e <alltraps>

80106025 <vector62>:
80106025:	6a 00                	push   $0x0
80106027:	6a 3e                	push   $0x3e
80106029:	e9 30 f9 ff ff       	jmp    8010595e <alltraps>

8010602e <vector63>:
8010602e:	6a 00                	push   $0x0
80106030:	6a 3f                	push   $0x3f
80106032:	e9 27 f9 ff ff       	jmp    8010595e <alltraps>

80106037 <vector64>:
80106037:	6a 00                	push   $0x0
80106039:	6a 40                	push   $0x40
8010603b:	e9 1e f9 ff ff       	jmp    8010595e <alltraps>

80106040 <vector65>:
80106040:	6a 00                	push   $0x0
80106042:	6a 41                	push   $0x41
80106044:	e9 15 f9 ff ff       	jmp    8010595e <alltraps>

80106049 <vector66>:
80106049:	6a 00                	push   $0x0
8010604b:	6a 42                	push   $0x42
8010604d:	e9 0c f9 ff ff       	jmp    8010595e <alltraps>

80106052 <vector67>:
80106052:	6a 00                	push   $0x0
80106054:	6a 43                	push   $0x43
80106056:	e9 03 f9 ff ff       	jmp    8010595e <alltraps>

8010605b <vector68>:
8010605b:	6a 00                	push   $0x0
8010605d:	6a 44                	push   $0x44
8010605f:	e9 fa f8 ff ff       	jmp    8010595e <alltraps>

80106064 <vector69>:
80106064:	6a 00                	push   $0x0
80106066:	6a 45                	push   $0x45
80106068:	e9 f1 f8 ff ff       	jmp    8010595e <alltraps>

8010606d <vector70>:
8010606d:	6a 00                	push   $0x0
8010606f:	6a 46                	push   $0x46
80106071:	e9 e8 f8 ff ff       	jmp    8010595e <alltraps>

80106076 <vector71>:
80106076:	6a 00                	push   $0x0
80106078:	6a 47                	push   $0x47
8010607a:	e9 df f8 ff ff       	jmp    8010595e <alltraps>

8010607f <vector72>:
8010607f:	6a 00                	push   $0x0
80106081:	6a 48                	push   $0x48
80106083:	e9 d6 f8 ff ff       	jmp    8010595e <alltraps>

80106088 <vector73>:
80106088:	6a 00                	push   $0x0
8010608a:	6a 49                	push   $0x49
8010608c:	e9 cd f8 ff ff       	jmp    8010595e <alltraps>

80106091 <vector74>:
80106091:	6a 00                	push   $0x0
80106093:	6a 4a                	push   $0x4a
80106095:	e9 c4 f8 ff ff       	jmp    8010595e <alltraps>

8010609a <vector75>:
8010609a:	6a 00                	push   $0x0
8010609c:	6a 4b                	push   $0x4b
8010609e:	e9 bb f8 ff ff       	jmp    8010595e <alltraps>

801060a3 <vector76>:
801060a3:	6a 00                	push   $0x0
801060a5:	6a 4c                	push   $0x4c
801060a7:	e9 b2 f8 ff ff       	jmp    8010595e <alltraps>

801060ac <vector77>:
801060ac:	6a 00                	push   $0x0
801060ae:	6a 4d                	push   $0x4d
801060b0:	e9 a9 f8 ff ff       	jmp    8010595e <alltraps>

801060b5 <vector78>:
801060b5:	6a 00                	push   $0x0
801060b7:	6a 4e                	push   $0x4e
801060b9:	e9 a0 f8 ff ff       	jmp    8010595e <alltraps>

801060be <vector79>:
801060be:	6a 00                	push   $0x0
801060c0:	6a 4f                	push   $0x4f
801060c2:	e9 97 f8 ff ff       	jmp    8010595e <alltraps>

801060c7 <vector80>:
801060c7:	6a 00                	push   $0x0
801060c9:	6a 50                	push   $0x50
801060cb:	e9 8e f8 ff ff       	jmp    8010595e <alltraps>

801060d0 <vector81>:
801060d0:	6a 00                	push   $0x0
801060d2:	6a 51                	push   $0x51
801060d4:	e9 85 f8 ff ff       	jmp    8010595e <alltraps>

801060d9 <vector82>:
801060d9:	6a 00                	push   $0x0
801060db:	6a 52                	push   $0x52
801060dd:	e9 7c f8 ff ff       	jmp    8010595e <alltraps>

801060e2 <vector83>:
801060e2:	6a 00                	push   $0x0
801060e4:	6a 53                	push   $0x53
801060e6:	e9 73 f8 ff ff       	jmp    8010595e <alltraps>

801060eb <vector84>:
801060eb:	6a 00                	push   $0x0
801060ed:	6a 54                	push   $0x54
801060ef:	e9 6a f8 ff ff       	jmp    8010595e <alltraps>

801060f4 <vector85>:
801060f4:	6a 00                	push   $0x0
801060f6:	6a 55                	push   $0x55
801060f8:	e9 61 f8 ff ff       	jmp    8010595e <alltraps>

801060fd <vector86>:
801060fd:	6a 00                	push   $0x0
801060ff:	6a 56                	push   $0x56
80106101:	e9 58 f8 ff ff       	jmp    8010595e <alltraps>

80106106 <vector87>:
80106106:	6a 00                	push   $0x0
80106108:	6a 57                	push   $0x57
8010610a:	e9 4f f8 ff ff       	jmp    8010595e <alltraps>

8010610f <vector88>:
8010610f:	6a 00                	push   $0x0
80106111:	6a 58                	push   $0x58
80106113:	e9 46 f8 ff ff       	jmp    8010595e <alltraps>

80106118 <vector89>:
80106118:	6a 00                	push   $0x0
8010611a:	6a 59                	push   $0x59
8010611c:	e9 3d f8 ff ff       	jmp    8010595e <alltraps>

80106121 <vector90>:
80106121:	6a 00                	push   $0x0
80106123:	6a 5a                	push   $0x5a
80106125:	e9 34 f8 ff ff       	jmp    8010595e <alltraps>

8010612a <vector91>:
8010612a:	6a 00                	push   $0x0
8010612c:	6a 5b                	push   $0x5b
8010612e:	e9 2b f8 ff ff       	jmp    8010595e <alltraps>

80106133 <vector92>:
80106133:	6a 00                	push   $0x0
80106135:	6a 5c                	push   $0x5c
80106137:	e9 22 f8 ff ff       	jmp    8010595e <alltraps>

8010613c <vector93>:
8010613c:	6a 00                	push   $0x0
8010613e:	6a 5d                	push   $0x5d
80106140:	e9 19 f8 ff ff       	jmp    8010595e <alltraps>

80106145 <vector94>:
80106145:	6a 00                	push   $0x0
80106147:	6a 5e                	push   $0x5e
80106149:	e9 10 f8 ff ff       	jmp    8010595e <alltraps>

8010614e <vector95>:
8010614e:	6a 00                	push   $0x0
80106150:	6a 5f                	push   $0x5f
80106152:	e9 07 f8 ff ff       	jmp    8010595e <alltraps>

80106157 <vector96>:
80106157:	6a 00                	push   $0x0
80106159:	6a 60                	push   $0x60
8010615b:	e9 fe f7 ff ff       	jmp    8010595e <alltraps>

80106160 <vector97>:
80106160:	6a 00                	push   $0x0
80106162:	6a 61                	push   $0x61
80106164:	e9 f5 f7 ff ff       	jmp    8010595e <alltraps>

80106169 <vector98>:
80106169:	6a 00                	push   $0x0
8010616b:	6a 62                	push   $0x62
8010616d:	e9 ec f7 ff ff       	jmp    8010595e <alltraps>

80106172 <vector99>:
80106172:	6a 00                	push   $0x0
80106174:	6a 63                	push   $0x63
80106176:	e9 e3 f7 ff ff       	jmp    8010595e <alltraps>

8010617b <vector100>:
8010617b:	6a 00                	push   $0x0
8010617d:	6a 64                	push   $0x64
8010617f:	e9 da f7 ff ff       	jmp    8010595e <alltraps>

80106184 <vector101>:
80106184:	6a 00                	push   $0x0
80106186:	6a 65                	push   $0x65
80106188:	e9 d1 f7 ff ff       	jmp    8010595e <alltraps>

8010618d <vector102>:
8010618d:	6a 00                	push   $0x0
8010618f:	6a 66                	push   $0x66
80106191:	e9 c8 f7 ff ff       	jmp    8010595e <alltraps>

80106196 <vector103>:
80106196:	6a 00                	push   $0x0
80106198:	6a 67                	push   $0x67
8010619a:	e9 bf f7 ff ff       	jmp    8010595e <alltraps>

8010619f <vector104>:
8010619f:	6a 00                	push   $0x0
801061a1:	6a 68                	push   $0x68
801061a3:	e9 b6 f7 ff ff       	jmp    8010595e <alltraps>

801061a8 <vector105>:
801061a8:	6a 00                	push   $0x0
801061aa:	6a 69                	push   $0x69
801061ac:	e9 ad f7 ff ff       	jmp    8010595e <alltraps>

801061b1 <vector106>:
801061b1:	6a 00                	push   $0x0
801061b3:	6a 6a                	push   $0x6a
801061b5:	e9 a4 f7 ff ff       	jmp    8010595e <alltraps>

801061ba <vector107>:
801061ba:	6a 00                	push   $0x0
801061bc:	6a 6b                	push   $0x6b
801061be:	e9 9b f7 ff ff       	jmp    8010595e <alltraps>

801061c3 <vector108>:
801061c3:	6a 00                	push   $0x0
801061c5:	6a 6c                	push   $0x6c
801061c7:	e9 92 f7 ff ff       	jmp    8010595e <alltraps>

801061cc <vector109>:
801061cc:	6a 00                	push   $0x0
801061ce:	6a 6d                	push   $0x6d
801061d0:	e9 89 f7 ff ff       	jmp    8010595e <alltraps>

801061d5 <vector110>:
801061d5:	6a 00                	push   $0x0
801061d7:	6a 6e                	push   $0x6e
801061d9:	e9 80 f7 ff ff       	jmp    8010595e <alltraps>

801061de <vector111>:
801061de:	6a 00                	push   $0x0
801061e0:	6a 6f                	push   $0x6f
801061e2:	e9 77 f7 ff ff       	jmp    8010595e <alltraps>

801061e7 <vector112>:
801061e7:	6a 00                	push   $0x0
801061e9:	6a 70                	push   $0x70
801061eb:	e9 6e f7 ff ff       	jmp    8010595e <alltraps>

801061f0 <vector113>:
801061f0:	6a 00                	push   $0x0
801061f2:	6a 71                	push   $0x71
801061f4:	e9 65 f7 ff ff       	jmp    8010595e <alltraps>

801061f9 <vector114>:
801061f9:	6a 00                	push   $0x0
801061fb:	6a 72                	push   $0x72
801061fd:	e9 5c f7 ff ff       	jmp    8010595e <alltraps>

80106202 <vector115>:
80106202:	6a 00                	push   $0x0
80106204:	6a 73                	push   $0x73
80106206:	e9 53 f7 ff ff       	jmp    8010595e <alltraps>

8010620b <vector116>:
8010620b:	6a 00                	push   $0x0
8010620d:	6a 74                	push   $0x74
8010620f:	e9 4a f7 ff ff       	jmp    8010595e <alltraps>

80106214 <vector117>:
80106214:	6a 00                	push   $0x0
80106216:	6a 75                	push   $0x75
80106218:	e9 41 f7 ff ff       	jmp    8010595e <alltraps>

8010621d <vector118>:
8010621d:	6a 00                	push   $0x0
8010621f:	6a 76                	push   $0x76
80106221:	e9 38 f7 ff ff       	jmp    8010595e <alltraps>

80106226 <vector119>:
80106226:	6a 00                	push   $0x0
80106228:	6a 77                	push   $0x77
8010622a:	e9 2f f7 ff ff       	jmp    8010595e <alltraps>

8010622f <vector120>:
8010622f:	6a 00                	push   $0x0
80106231:	6a 78                	push   $0x78
80106233:	e9 26 f7 ff ff       	jmp    8010595e <alltraps>

80106238 <vector121>:
80106238:	6a 00                	push   $0x0
8010623a:	6a 79                	push   $0x79
8010623c:	e9 1d f7 ff ff       	jmp    8010595e <alltraps>

80106241 <vector122>:
80106241:	6a 00                	push   $0x0
80106243:	6a 7a                	push   $0x7a
80106245:	e9 14 f7 ff ff       	jmp    8010595e <alltraps>

8010624a <vector123>:
8010624a:	6a 00                	push   $0x0
8010624c:	6a 7b                	push   $0x7b
8010624e:	e9 0b f7 ff ff       	jmp    8010595e <alltraps>

80106253 <vector124>:
80106253:	6a 00                	push   $0x0
80106255:	6a 7c                	push   $0x7c
80106257:	e9 02 f7 ff ff       	jmp    8010595e <alltraps>

8010625c <vector125>:
8010625c:	6a 00                	push   $0x0
8010625e:	6a 7d                	push   $0x7d
80106260:	e9 f9 f6 ff ff       	jmp    8010595e <alltraps>

80106265 <vector126>:
80106265:	6a 00                	push   $0x0
80106267:	6a 7e                	push   $0x7e
80106269:	e9 f0 f6 ff ff       	jmp    8010595e <alltraps>

8010626e <vector127>:
8010626e:	6a 00                	push   $0x0
80106270:	6a 7f                	push   $0x7f
80106272:	e9 e7 f6 ff ff       	jmp    8010595e <alltraps>

80106277 <vector128>:
80106277:	6a 00                	push   $0x0
80106279:	68 80 00 00 00       	push   $0x80
8010627e:	e9 db f6 ff ff       	jmp    8010595e <alltraps>

80106283 <vector129>:
80106283:	6a 00                	push   $0x0
80106285:	68 81 00 00 00       	push   $0x81
8010628a:	e9 cf f6 ff ff       	jmp    8010595e <alltraps>

8010628f <vector130>:
8010628f:	6a 00                	push   $0x0
80106291:	68 82 00 00 00       	push   $0x82
80106296:	e9 c3 f6 ff ff       	jmp    8010595e <alltraps>

8010629b <vector131>:
8010629b:	6a 00                	push   $0x0
8010629d:	68 83 00 00 00       	push   $0x83
801062a2:	e9 b7 f6 ff ff       	jmp    8010595e <alltraps>

801062a7 <vector132>:
801062a7:	6a 00                	push   $0x0
801062a9:	68 84 00 00 00       	push   $0x84
801062ae:	e9 ab f6 ff ff       	jmp    8010595e <alltraps>

801062b3 <vector133>:
801062b3:	6a 00                	push   $0x0
801062b5:	68 85 00 00 00       	push   $0x85
801062ba:	e9 9f f6 ff ff       	jmp    8010595e <alltraps>

801062bf <vector134>:
801062bf:	6a 00                	push   $0x0
801062c1:	68 86 00 00 00       	push   $0x86
801062c6:	e9 93 f6 ff ff       	jmp    8010595e <alltraps>

801062cb <vector135>:
801062cb:	6a 00                	push   $0x0
801062cd:	68 87 00 00 00       	push   $0x87
801062d2:	e9 87 f6 ff ff       	jmp    8010595e <alltraps>

801062d7 <vector136>:
801062d7:	6a 00                	push   $0x0
801062d9:	68 88 00 00 00       	push   $0x88
801062de:	e9 7b f6 ff ff       	jmp    8010595e <alltraps>

801062e3 <vector137>:
801062e3:	6a 00                	push   $0x0
801062e5:	68 89 00 00 00       	push   $0x89
801062ea:	e9 6f f6 ff ff       	jmp    8010595e <alltraps>

801062ef <vector138>:
801062ef:	6a 00                	push   $0x0
801062f1:	68 8a 00 00 00       	push   $0x8a
801062f6:	e9 63 f6 ff ff       	jmp    8010595e <alltraps>

801062fb <vector139>:
801062fb:	6a 00                	push   $0x0
801062fd:	68 8b 00 00 00       	push   $0x8b
80106302:	e9 57 f6 ff ff       	jmp    8010595e <alltraps>

80106307 <vector140>:
80106307:	6a 00                	push   $0x0
80106309:	68 8c 00 00 00       	push   $0x8c
8010630e:	e9 4b f6 ff ff       	jmp    8010595e <alltraps>

80106313 <vector141>:
80106313:	6a 00                	push   $0x0
80106315:	68 8d 00 00 00       	push   $0x8d
8010631a:	e9 3f f6 ff ff       	jmp    8010595e <alltraps>

8010631f <vector142>:
8010631f:	6a 00                	push   $0x0
80106321:	68 8e 00 00 00       	push   $0x8e
80106326:	e9 33 f6 ff ff       	jmp    8010595e <alltraps>

8010632b <vector143>:
8010632b:	6a 00                	push   $0x0
8010632d:	68 8f 00 00 00       	push   $0x8f
80106332:	e9 27 f6 ff ff       	jmp    8010595e <alltraps>

80106337 <vector144>:
80106337:	6a 00                	push   $0x0
80106339:	68 90 00 00 00       	push   $0x90
8010633e:	e9 1b f6 ff ff       	jmp    8010595e <alltraps>

80106343 <vector145>:
80106343:	6a 00                	push   $0x0
80106345:	68 91 00 00 00       	push   $0x91
8010634a:	e9 0f f6 ff ff       	jmp    8010595e <alltraps>

8010634f <vector146>:
8010634f:	6a 00                	push   $0x0
80106351:	68 92 00 00 00       	push   $0x92
80106356:	e9 03 f6 ff ff       	jmp    8010595e <alltraps>

8010635b <vector147>:
8010635b:	6a 00                	push   $0x0
8010635d:	68 93 00 00 00       	push   $0x93
80106362:	e9 f7 f5 ff ff       	jmp    8010595e <alltraps>

80106367 <vector148>:
80106367:	6a 00                	push   $0x0
80106369:	68 94 00 00 00       	push   $0x94
8010636e:	e9 eb f5 ff ff       	jmp    8010595e <alltraps>

80106373 <vector149>:
80106373:	6a 00                	push   $0x0
80106375:	68 95 00 00 00       	push   $0x95
8010637a:	e9 df f5 ff ff       	jmp    8010595e <alltraps>

8010637f <vector150>:
8010637f:	6a 00                	push   $0x0
80106381:	68 96 00 00 00       	push   $0x96
80106386:	e9 d3 f5 ff ff       	jmp    8010595e <alltraps>

8010638b <vector151>:
8010638b:	6a 00                	push   $0x0
8010638d:	68 97 00 00 00       	push   $0x97
80106392:	e9 c7 f5 ff ff       	jmp    8010595e <alltraps>

80106397 <vector152>:
80106397:	6a 00                	push   $0x0
80106399:	68 98 00 00 00       	push   $0x98
8010639e:	e9 bb f5 ff ff       	jmp    8010595e <alltraps>

801063a3 <vector153>:
801063a3:	6a 00                	push   $0x0
801063a5:	68 99 00 00 00       	push   $0x99
801063aa:	e9 af f5 ff ff       	jmp    8010595e <alltraps>

801063af <vector154>:
801063af:	6a 00                	push   $0x0
801063b1:	68 9a 00 00 00       	push   $0x9a
801063b6:	e9 a3 f5 ff ff       	jmp    8010595e <alltraps>

801063bb <vector155>:
801063bb:	6a 00                	push   $0x0
801063bd:	68 9b 00 00 00       	push   $0x9b
801063c2:	e9 97 f5 ff ff       	jmp    8010595e <alltraps>

801063c7 <vector156>:
801063c7:	6a 00                	push   $0x0
801063c9:	68 9c 00 00 00       	push   $0x9c
801063ce:	e9 8b f5 ff ff       	jmp    8010595e <alltraps>

801063d3 <vector157>:
801063d3:	6a 00                	push   $0x0
801063d5:	68 9d 00 00 00       	push   $0x9d
801063da:	e9 7f f5 ff ff       	jmp    8010595e <alltraps>

801063df <vector158>:
801063df:	6a 00                	push   $0x0
801063e1:	68 9e 00 00 00       	push   $0x9e
801063e6:	e9 73 f5 ff ff       	jmp    8010595e <alltraps>

801063eb <vector159>:
801063eb:	6a 00                	push   $0x0
801063ed:	68 9f 00 00 00       	push   $0x9f
801063f2:	e9 67 f5 ff ff       	jmp    8010595e <alltraps>

801063f7 <vector160>:
801063f7:	6a 00                	push   $0x0
801063f9:	68 a0 00 00 00       	push   $0xa0
801063fe:	e9 5b f5 ff ff       	jmp    8010595e <alltraps>

80106403 <vector161>:
80106403:	6a 00                	push   $0x0
80106405:	68 a1 00 00 00       	push   $0xa1
8010640a:	e9 4f f5 ff ff       	jmp    8010595e <alltraps>

8010640f <vector162>:
8010640f:	6a 00                	push   $0x0
80106411:	68 a2 00 00 00       	push   $0xa2
80106416:	e9 43 f5 ff ff       	jmp    8010595e <alltraps>

8010641b <vector163>:
8010641b:	6a 00                	push   $0x0
8010641d:	68 a3 00 00 00       	push   $0xa3
80106422:	e9 37 f5 ff ff       	jmp    8010595e <alltraps>

80106427 <vector164>:
80106427:	6a 00                	push   $0x0
80106429:	68 a4 00 00 00       	push   $0xa4
8010642e:	e9 2b f5 ff ff       	jmp    8010595e <alltraps>

80106433 <vector165>:
80106433:	6a 00                	push   $0x0
80106435:	68 a5 00 00 00       	push   $0xa5
8010643a:	e9 1f f5 ff ff       	jmp    8010595e <alltraps>

8010643f <vector166>:
8010643f:	6a 00                	push   $0x0
80106441:	68 a6 00 00 00       	push   $0xa6
80106446:	e9 13 f5 ff ff       	jmp    8010595e <alltraps>

8010644b <vector167>:
8010644b:	6a 00                	push   $0x0
8010644d:	68 a7 00 00 00       	push   $0xa7
80106452:	e9 07 f5 ff ff       	jmp    8010595e <alltraps>

80106457 <vector168>:
80106457:	6a 00                	push   $0x0
80106459:	68 a8 00 00 00       	push   $0xa8
8010645e:	e9 fb f4 ff ff       	jmp    8010595e <alltraps>

80106463 <vector169>:
80106463:	6a 00                	push   $0x0
80106465:	68 a9 00 00 00       	push   $0xa9
8010646a:	e9 ef f4 ff ff       	jmp    8010595e <alltraps>

8010646f <vector170>:
8010646f:	6a 00                	push   $0x0
80106471:	68 aa 00 00 00       	push   $0xaa
80106476:	e9 e3 f4 ff ff       	jmp    8010595e <alltraps>

8010647b <vector171>:
8010647b:	6a 00                	push   $0x0
8010647d:	68 ab 00 00 00       	push   $0xab
80106482:	e9 d7 f4 ff ff       	jmp    8010595e <alltraps>

80106487 <vector172>:
80106487:	6a 00                	push   $0x0
80106489:	68 ac 00 00 00       	push   $0xac
8010648e:	e9 cb f4 ff ff       	jmp    8010595e <alltraps>

80106493 <vector173>:
80106493:	6a 00                	push   $0x0
80106495:	68 ad 00 00 00       	push   $0xad
8010649a:	e9 bf f4 ff ff       	jmp    8010595e <alltraps>

8010649f <vector174>:
8010649f:	6a 00                	push   $0x0
801064a1:	68 ae 00 00 00       	push   $0xae
801064a6:	e9 b3 f4 ff ff       	jmp    8010595e <alltraps>

801064ab <vector175>:
801064ab:	6a 00                	push   $0x0
801064ad:	68 af 00 00 00       	push   $0xaf
801064b2:	e9 a7 f4 ff ff       	jmp    8010595e <alltraps>

801064b7 <vector176>:
801064b7:	6a 00                	push   $0x0
801064b9:	68 b0 00 00 00       	push   $0xb0
801064be:	e9 9b f4 ff ff       	jmp    8010595e <alltraps>

801064c3 <vector177>:
801064c3:	6a 00                	push   $0x0
801064c5:	68 b1 00 00 00       	push   $0xb1
801064ca:	e9 8f f4 ff ff       	jmp    8010595e <alltraps>

801064cf <vector178>:
801064cf:	6a 00                	push   $0x0
801064d1:	68 b2 00 00 00       	push   $0xb2
801064d6:	e9 83 f4 ff ff       	jmp    8010595e <alltraps>

801064db <vector179>:
801064db:	6a 00                	push   $0x0
801064dd:	68 b3 00 00 00       	push   $0xb3
801064e2:	e9 77 f4 ff ff       	jmp    8010595e <alltraps>

801064e7 <vector180>:
801064e7:	6a 00                	push   $0x0
801064e9:	68 b4 00 00 00       	push   $0xb4
801064ee:	e9 6b f4 ff ff       	jmp    8010595e <alltraps>

801064f3 <vector181>:
801064f3:	6a 00                	push   $0x0
801064f5:	68 b5 00 00 00       	push   $0xb5
801064fa:	e9 5f f4 ff ff       	jmp    8010595e <alltraps>

801064ff <vector182>:
801064ff:	6a 00                	push   $0x0
80106501:	68 b6 00 00 00       	push   $0xb6
80106506:	e9 53 f4 ff ff       	jmp    8010595e <alltraps>

8010650b <vector183>:
8010650b:	6a 00                	push   $0x0
8010650d:	68 b7 00 00 00       	push   $0xb7
80106512:	e9 47 f4 ff ff       	jmp    8010595e <alltraps>

80106517 <vector184>:
80106517:	6a 00                	push   $0x0
80106519:	68 b8 00 00 00       	push   $0xb8
8010651e:	e9 3b f4 ff ff       	jmp    8010595e <alltraps>

80106523 <vector185>:
80106523:	6a 00                	push   $0x0
80106525:	68 b9 00 00 00       	push   $0xb9
8010652a:	e9 2f f4 ff ff       	jmp    8010595e <alltraps>

8010652f <vector186>:
8010652f:	6a 00                	push   $0x0
80106531:	68 ba 00 00 00       	push   $0xba
80106536:	e9 23 f4 ff ff       	jmp    8010595e <alltraps>

8010653b <vector187>:
8010653b:	6a 00                	push   $0x0
8010653d:	68 bb 00 00 00       	push   $0xbb
80106542:	e9 17 f4 ff ff       	jmp    8010595e <alltraps>

80106547 <vector188>:
80106547:	6a 00                	push   $0x0
80106549:	68 bc 00 00 00       	push   $0xbc
8010654e:	e9 0b f4 ff ff       	jmp    8010595e <alltraps>

80106553 <vector189>:
80106553:	6a 00                	push   $0x0
80106555:	68 bd 00 00 00       	push   $0xbd
8010655a:	e9 ff f3 ff ff       	jmp    8010595e <alltraps>

8010655f <vector190>:
8010655f:	6a 00                	push   $0x0
80106561:	68 be 00 00 00       	push   $0xbe
80106566:	e9 f3 f3 ff ff       	jmp    8010595e <alltraps>

8010656b <vector191>:
8010656b:	6a 00                	push   $0x0
8010656d:	68 bf 00 00 00       	push   $0xbf
80106572:	e9 e7 f3 ff ff       	jmp    8010595e <alltraps>

80106577 <vector192>:
80106577:	6a 00                	push   $0x0
80106579:	68 c0 00 00 00       	push   $0xc0
8010657e:	e9 db f3 ff ff       	jmp    8010595e <alltraps>

80106583 <vector193>:
80106583:	6a 00                	push   $0x0
80106585:	68 c1 00 00 00       	push   $0xc1
8010658a:	e9 cf f3 ff ff       	jmp    8010595e <alltraps>

8010658f <vector194>:
8010658f:	6a 00                	push   $0x0
80106591:	68 c2 00 00 00       	push   $0xc2
80106596:	e9 c3 f3 ff ff       	jmp    8010595e <alltraps>

8010659b <vector195>:
8010659b:	6a 00                	push   $0x0
8010659d:	68 c3 00 00 00       	push   $0xc3
801065a2:	e9 b7 f3 ff ff       	jmp    8010595e <alltraps>

801065a7 <vector196>:
801065a7:	6a 00                	push   $0x0
801065a9:	68 c4 00 00 00       	push   $0xc4
801065ae:	e9 ab f3 ff ff       	jmp    8010595e <alltraps>

801065b3 <vector197>:
801065b3:	6a 00                	push   $0x0
801065b5:	68 c5 00 00 00       	push   $0xc5
801065ba:	e9 9f f3 ff ff       	jmp    8010595e <alltraps>

801065bf <vector198>:
801065bf:	6a 00                	push   $0x0
801065c1:	68 c6 00 00 00       	push   $0xc6
801065c6:	e9 93 f3 ff ff       	jmp    8010595e <alltraps>

801065cb <vector199>:
801065cb:	6a 00                	push   $0x0
801065cd:	68 c7 00 00 00       	push   $0xc7
801065d2:	e9 87 f3 ff ff       	jmp    8010595e <alltraps>

801065d7 <vector200>:
801065d7:	6a 00                	push   $0x0
801065d9:	68 c8 00 00 00       	push   $0xc8
801065de:	e9 7b f3 ff ff       	jmp    8010595e <alltraps>

801065e3 <vector201>:
801065e3:	6a 00                	push   $0x0
801065e5:	68 c9 00 00 00       	push   $0xc9
801065ea:	e9 6f f3 ff ff       	jmp    8010595e <alltraps>

801065ef <vector202>:
801065ef:	6a 00                	push   $0x0
801065f1:	68 ca 00 00 00       	push   $0xca
801065f6:	e9 63 f3 ff ff       	jmp    8010595e <alltraps>

801065fb <vector203>:
801065fb:	6a 00                	push   $0x0
801065fd:	68 cb 00 00 00       	push   $0xcb
80106602:	e9 57 f3 ff ff       	jmp    8010595e <alltraps>

80106607 <vector204>:
80106607:	6a 00                	push   $0x0
80106609:	68 cc 00 00 00       	push   $0xcc
8010660e:	e9 4b f3 ff ff       	jmp    8010595e <alltraps>

80106613 <vector205>:
80106613:	6a 00                	push   $0x0
80106615:	68 cd 00 00 00       	push   $0xcd
8010661a:	e9 3f f3 ff ff       	jmp    8010595e <alltraps>

8010661f <vector206>:
8010661f:	6a 00                	push   $0x0
80106621:	68 ce 00 00 00       	push   $0xce
80106626:	e9 33 f3 ff ff       	jmp    8010595e <alltraps>

8010662b <vector207>:
8010662b:	6a 00                	push   $0x0
8010662d:	68 cf 00 00 00       	push   $0xcf
80106632:	e9 27 f3 ff ff       	jmp    8010595e <alltraps>

80106637 <vector208>:
80106637:	6a 00                	push   $0x0
80106639:	68 d0 00 00 00       	push   $0xd0
8010663e:	e9 1b f3 ff ff       	jmp    8010595e <alltraps>

80106643 <vector209>:
80106643:	6a 00                	push   $0x0
80106645:	68 d1 00 00 00       	push   $0xd1
8010664a:	e9 0f f3 ff ff       	jmp    8010595e <alltraps>

8010664f <vector210>:
8010664f:	6a 00                	push   $0x0
80106651:	68 d2 00 00 00       	push   $0xd2
80106656:	e9 03 f3 ff ff       	jmp    8010595e <alltraps>

8010665b <vector211>:
8010665b:	6a 00                	push   $0x0
8010665d:	68 d3 00 00 00       	push   $0xd3
80106662:	e9 f7 f2 ff ff       	jmp    8010595e <alltraps>

80106667 <vector212>:
80106667:	6a 00                	push   $0x0
80106669:	68 d4 00 00 00       	push   $0xd4
8010666e:	e9 eb f2 ff ff       	jmp    8010595e <alltraps>

80106673 <vector213>:
80106673:	6a 00                	push   $0x0
80106675:	68 d5 00 00 00       	push   $0xd5
8010667a:	e9 df f2 ff ff       	jmp    8010595e <alltraps>

8010667f <vector214>:
8010667f:	6a 00                	push   $0x0
80106681:	68 d6 00 00 00       	push   $0xd6
80106686:	e9 d3 f2 ff ff       	jmp    8010595e <alltraps>

8010668b <vector215>:
8010668b:	6a 00                	push   $0x0
8010668d:	68 d7 00 00 00       	push   $0xd7
80106692:	e9 c7 f2 ff ff       	jmp    8010595e <alltraps>

80106697 <vector216>:
80106697:	6a 00                	push   $0x0
80106699:	68 d8 00 00 00       	push   $0xd8
8010669e:	e9 bb f2 ff ff       	jmp    8010595e <alltraps>

801066a3 <vector217>:
801066a3:	6a 00                	push   $0x0
801066a5:	68 d9 00 00 00       	push   $0xd9
801066aa:	e9 af f2 ff ff       	jmp    8010595e <alltraps>

801066af <vector218>:
801066af:	6a 00                	push   $0x0
801066b1:	68 da 00 00 00       	push   $0xda
801066b6:	e9 a3 f2 ff ff       	jmp    8010595e <alltraps>

801066bb <vector219>:
801066bb:	6a 00                	push   $0x0
801066bd:	68 db 00 00 00       	push   $0xdb
801066c2:	e9 97 f2 ff ff       	jmp    8010595e <alltraps>

801066c7 <vector220>:
801066c7:	6a 00                	push   $0x0
801066c9:	68 dc 00 00 00       	push   $0xdc
801066ce:	e9 8b f2 ff ff       	jmp    8010595e <alltraps>

801066d3 <vector221>:
801066d3:	6a 00                	push   $0x0
801066d5:	68 dd 00 00 00       	push   $0xdd
801066da:	e9 7f f2 ff ff       	jmp    8010595e <alltraps>

801066df <vector222>:
801066df:	6a 00                	push   $0x0
801066e1:	68 de 00 00 00       	push   $0xde
801066e6:	e9 73 f2 ff ff       	jmp    8010595e <alltraps>

801066eb <vector223>:
801066eb:	6a 00                	push   $0x0
801066ed:	68 df 00 00 00       	push   $0xdf
801066f2:	e9 67 f2 ff ff       	jmp    8010595e <alltraps>

801066f7 <vector224>:
801066f7:	6a 00                	push   $0x0
801066f9:	68 e0 00 00 00       	push   $0xe0
801066fe:	e9 5b f2 ff ff       	jmp    8010595e <alltraps>

80106703 <vector225>:
80106703:	6a 00                	push   $0x0
80106705:	68 e1 00 00 00       	push   $0xe1
8010670a:	e9 4f f2 ff ff       	jmp    8010595e <alltraps>

8010670f <vector226>:
8010670f:	6a 00                	push   $0x0
80106711:	68 e2 00 00 00       	push   $0xe2
80106716:	e9 43 f2 ff ff       	jmp    8010595e <alltraps>

8010671b <vector227>:
8010671b:	6a 00                	push   $0x0
8010671d:	68 e3 00 00 00       	push   $0xe3
80106722:	e9 37 f2 ff ff       	jmp    8010595e <alltraps>

80106727 <vector228>:
80106727:	6a 00                	push   $0x0
80106729:	68 e4 00 00 00       	push   $0xe4
8010672e:	e9 2b f2 ff ff       	jmp    8010595e <alltraps>

80106733 <vector229>:
80106733:	6a 00                	push   $0x0
80106735:	68 e5 00 00 00       	push   $0xe5
8010673a:	e9 1f f2 ff ff       	jmp    8010595e <alltraps>

8010673f <vector230>:
8010673f:	6a 00                	push   $0x0
80106741:	68 e6 00 00 00       	push   $0xe6
80106746:	e9 13 f2 ff ff       	jmp    8010595e <alltraps>

8010674b <vector231>:
8010674b:	6a 00                	push   $0x0
8010674d:	68 e7 00 00 00       	push   $0xe7
80106752:	e9 07 f2 ff ff       	jmp    8010595e <alltraps>

80106757 <vector232>:
80106757:	6a 00                	push   $0x0
80106759:	68 e8 00 00 00       	push   $0xe8
8010675e:	e9 fb f1 ff ff       	jmp    8010595e <alltraps>

80106763 <vector233>:
80106763:	6a 00                	push   $0x0
80106765:	68 e9 00 00 00       	push   $0xe9
8010676a:	e9 ef f1 ff ff       	jmp    8010595e <alltraps>

8010676f <vector234>:
8010676f:	6a 00                	push   $0x0
80106771:	68 ea 00 00 00       	push   $0xea
80106776:	e9 e3 f1 ff ff       	jmp    8010595e <alltraps>

8010677b <vector235>:
8010677b:	6a 00                	push   $0x0
8010677d:	68 eb 00 00 00       	push   $0xeb
80106782:	e9 d7 f1 ff ff       	jmp    8010595e <alltraps>

80106787 <vector236>:
80106787:	6a 00                	push   $0x0
80106789:	68 ec 00 00 00       	push   $0xec
8010678e:	e9 cb f1 ff ff       	jmp    8010595e <alltraps>

80106793 <vector237>:
80106793:	6a 00                	push   $0x0
80106795:	68 ed 00 00 00       	push   $0xed
8010679a:	e9 bf f1 ff ff       	jmp    8010595e <alltraps>

8010679f <vector238>:
8010679f:	6a 00                	push   $0x0
801067a1:	68 ee 00 00 00       	push   $0xee
801067a6:	e9 b3 f1 ff ff       	jmp    8010595e <alltraps>

801067ab <vector239>:
801067ab:	6a 00                	push   $0x0
801067ad:	68 ef 00 00 00       	push   $0xef
801067b2:	e9 a7 f1 ff ff       	jmp    8010595e <alltraps>

801067b7 <vector240>:
801067b7:	6a 00                	push   $0x0
801067b9:	68 f0 00 00 00       	push   $0xf0
801067be:	e9 9b f1 ff ff       	jmp    8010595e <alltraps>

801067c3 <vector241>:
801067c3:	6a 00                	push   $0x0
801067c5:	68 f1 00 00 00       	push   $0xf1
801067ca:	e9 8f f1 ff ff       	jmp    8010595e <alltraps>

801067cf <vector242>:
801067cf:	6a 00                	push   $0x0
801067d1:	68 f2 00 00 00       	push   $0xf2
801067d6:	e9 83 f1 ff ff       	jmp    8010595e <alltraps>

801067db <vector243>:
801067db:	6a 00                	push   $0x0
801067dd:	68 f3 00 00 00       	push   $0xf3
801067e2:	e9 77 f1 ff ff       	jmp    8010595e <alltraps>

801067e7 <vector244>:
801067e7:	6a 00                	push   $0x0
801067e9:	68 f4 00 00 00       	push   $0xf4
801067ee:	e9 6b f1 ff ff       	jmp    8010595e <alltraps>

801067f3 <vector245>:
801067f3:	6a 00                	push   $0x0
801067f5:	68 f5 00 00 00       	push   $0xf5
801067fa:	e9 5f f1 ff ff       	jmp    8010595e <alltraps>

801067ff <vector246>:
801067ff:	6a 00                	push   $0x0
80106801:	68 f6 00 00 00       	push   $0xf6
80106806:	e9 53 f1 ff ff       	jmp    8010595e <alltraps>

8010680b <vector247>:
8010680b:	6a 00                	push   $0x0
8010680d:	68 f7 00 00 00       	push   $0xf7
80106812:	e9 47 f1 ff ff       	jmp    8010595e <alltraps>

80106817 <vector248>:
80106817:	6a 00                	push   $0x0
80106819:	68 f8 00 00 00       	push   $0xf8
8010681e:	e9 3b f1 ff ff       	jmp    8010595e <alltraps>

80106823 <vector249>:
80106823:	6a 00                	push   $0x0
80106825:	68 f9 00 00 00       	push   $0xf9
8010682a:	e9 2f f1 ff ff       	jmp    8010595e <alltraps>

8010682f <vector250>:
8010682f:	6a 00                	push   $0x0
80106831:	68 fa 00 00 00       	push   $0xfa
80106836:	e9 23 f1 ff ff       	jmp    8010595e <alltraps>

8010683b <vector251>:
8010683b:	6a 00                	push   $0x0
8010683d:	68 fb 00 00 00       	push   $0xfb
80106842:	e9 17 f1 ff ff       	jmp    8010595e <alltraps>

80106847 <vector252>:
80106847:	6a 00                	push   $0x0
80106849:	68 fc 00 00 00       	push   $0xfc
8010684e:	e9 0b f1 ff ff       	jmp    8010595e <alltraps>

80106853 <vector253>:
80106853:	6a 00                	push   $0x0
80106855:	68 fd 00 00 00       	push   $0xfd
8010685a:	e9 ff f0 ff ff       	jmp    8010595e <alltraps>

8010685f <vector254>:
8010685f:	6a 00                	push   $0x0
80106861:	68 fe 00 00 00       	push   $0xfe
80106866:	e9 f3 f0 ff ff       	jmp    8010595e <alltraps>

8010686b <vector255>:
8010686b:	6a 00                	push   $0x0
8010686d:	68 ff 00 00 00       	push   $0xff
80106872:	e9 e7 f0 ff ff       	jmp    8010595e <alltraps>
80106877:	66 90                	xchg   %ax,%ax
80106879:	66 90                	xchg   %ax,%ax
8010687b:	66 90                	xchg   %ax,%ax
8010687d:	66 90                	xchg   %ax,%ax
8010687f:	90                   	nop

80106880 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	57                   	push   %edi
80106884:	56                   	push   %esi
80106885:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106886:	89 d3                	mov    %edx,%ebx
{
80106888:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010688a:	c1 eb 16             	shr    $0x16,%ebx
8010688d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106890:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106893:	8b 06                	mov    (%esi),%eax
80106895:	a8 01                	test   $0x1,%al
80106897:	74 27                	je     801068c0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106899:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010689e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068a4:	c1 ef 0a             	shr    $0xa,%edi
}
801068a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801068aa:	89 fa                	mov    %edi,%edx
801068ac:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801068b2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801068b5:	5b                   	pop    %ebx
801068b6:	5e                   	pop    %esi
801068b7:	5f                   	pop    %edi
801068b8:	5d                   	pop    %ebp
801068b9:	c3                   	ret    
801068ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068c0:	85 c9                	test   %ecx,%ecx
801068c2:	74 2c                	je     801068f0 <walkpgdir+0x70>
801068c4:	e8 07 bc ff ff       	call   801024d0 <kalloc>
801068c9:	85 c0                	test   %eax,%eax
801068cb:	89 c3                	mov    %eax,%ebx
801068cd:	74 21                	je     801068f0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801068cf:	83 ec 04             	sub    $0x4,%esp
801068d2:	68 00 10 00 00       	push   $0x1000
801068d7:	6a 00                	push   $0x0
801068d9:	50                   	push   %eax
801068da:	e8 f1 dd ff ff       	call   801046d0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801068df:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801068e5:	83 c4 10             	add    $0x10,%esp
801068e8:	83 c8 07             	or     $0x7,%eax
801068eb:	89 06                	mov    %eax,(%esi)
801068ed:	eb b5                	jmp    801068a4 <walkpgdir+0x24>
801068ef:	90                   	nop
}
801068f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801068f3:	31 c0                	xor    %eax,%eax
}
801068f5:	5b                   	pop    %ebx
801068f6:	5e                   	pop    %esi
801068f7:	5f                   	pop    %edi
801068f8:	5d                   	pop    %ebp
801068f9:	c3                   	ret    
801068fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106900 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	57                   	push   %edi
80106904:	56                   	push   %esi
80106905:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106906:	89 d3                	mov    %edx,%ebx
80106908:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010690e:	83 ec 1c             	sub    $0x1c,%esp
80106911:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106914:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106918:	8b 7d 08             	mov    0x8(%ebp),%edi
8010691b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106920:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106923:	8b 45 0c             	mov    0xc(%ebp),%eax
80106926:	29 df                	sub    %ebx,%edi
80106928:	83 c8 01             	or     $0x1,%eax
8010692b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010692e:	eb 15                	jmp    80106945 <mappages+0x45>
    if(*pte & PTE_P)
80106930:	f6 00 01             	testb  $0x1,(%eax)
80106933:	75 45                	jne    8010697a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106935:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106938:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010693b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010693d:	74 31                	je     80106970 <mappages+0x70>
      break;
    a += PGSIZE;
8010693f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106945:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106948:	b9 01 00 00 00       	mov    $0x1,%ecx
8010694d:	89 da                	mov    %ebx,%edx
8010694f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106952:	e8 29 ff ff ff       	call   80106880 <walkpgdir>
80106957:	85 c0                	test   %eax,%eax
80106959:	75 d5                	jne    80106930 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010695b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010695e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106963:	5b                   	pop    %ebx
80106964:	5e                   	pop    %esi
80106965:	5f                   	pop    %edi
80106966:	5d                   	pop    %ebp
80106967:	c3                   	ret    
80106968:	90                   	nop
80106969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106970:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106973:	31 c0                	xor    %eax,%eax
}
80106975:	5b                   	pop    %ebx
80106976:	5e                   	pop    %esi
80106977:	5f                   	pop    %edi
80106978:	5d                   	pop    %ebp
80106979:	c3                   	ret    
      panic("remap");
8010697a:	83 ec 0c             	sub    $0xc,%esp
8010697d:	68 90 7a 10 80       	push   $0x80107a90
80106982:	e8 09 9a ff ff       	call   80100390 <panic>
80106987:	89 f6                	mov    %esi,%esi
80106989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106990 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	57                   	push   %edi
80106994:	56                   	push   %esi
80106995:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106996:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010699c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010699e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069a4:	83 ec 1c             	sub    $0x1c,%esp
801069a7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801069aa:	39 d3                	cmp    %edx,%ebx
801069ac:	73 60                	jae    80106a0e <deallocuvm.part.0+0x7e>
801069ae:	89 d6                	mov    %edx,%esi
801069b0:	eb 3d                	jmp    801069ef <deallocuvm.part.0+0x5f>
801069b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
801069b8:	8b 10                	mov    (%eax),%edx
801069ba:	f6 c2 01             	test   $0x1,%dl
801069bd:	74 26                	je     801069e5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801069bf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801069c5:	74 52                	je     80106a19 <deallocuvm.part.0+0x89>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801069c7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801069ca:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801069d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801069d3:	52                   	push   %edx
801069d4:	e8 47 b9 ff ff       	call   80102320 <kfree>
      *pte = 0;
801069d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069dc:	83 c4 10             	add    $0x10,%esp
801069df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801069e5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069eb:	39 f3                	cmp    %esi,%ebx
801069ed:	73 1f                	jae    80106a0e <deallocuvm.part.0+0x7e>
    pte = walkpgdir(pgdir, (char*)a, 0);
801069ef:	31 c9                	xor    %ecx,%ecx
801069f1:	89 da                	mov    %ebx,%edx
801069f3:	89 f8                	mov    %edi,%eax
801069f5:	e8 86 fe ff ff       	call   80106880 <walkpgdir>
    if(!pte)
801069fa:	85 c0                	test   %eax,%eax
801069fc:	75 ba                	jne    801069b8 <deallocuvm.part.0+0x28>
      a += (NPTENTRIES - 1) * PGSIZE;
801069fe:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106a04:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a0a:	39 f3                	cmp    %esi,%ebx
80106a0c:	72 e1                	jb     801069ef <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106a0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a14:	5b                   	pop    %ebx
80106a15:	5e                   	pop    %esi
80106a16:	5f                   	pop    %edi
80106a17:	5d                   	pop    %ebp
80106a18:	c3                   	ret    
        panic("kfree");
80106a19:	83 ec 0c             	sub    $0xc,%esp
80106a1c:	68 d2 73 10 80       	push   $0x801073d2
80106a21:	e8 6a 99 ff ff       	call   80100390 <panic>
80106a26:	8d 76 00             	lea    0x0(%esi),%esi
80106a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a30 <seginit>:
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	53                   	push   %ebx
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106a34:	31 db                	xor    %ebx,%ebx
{
80106a36:	83 ec 14             	sub    $0x14,%esp
  c = &cpus[cpunum()];
80106a39:	e8 02 bd ff ff       	call   80102740 <cpunum>
80106a3e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106a44:	8d 90 a0 27 11 80    	lea    -0x7feed860(%eax),%edx
80106a4a:	8d 88 54 28 11 80    	lea    -0x7feed7ac(%eax),%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a50:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106a57:	ff 00 00 
80106a5a:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106a61:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a64:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106a6b:	ff 00 00 
80106a6e:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106a75:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a78:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106a7f:	ff 00 00 
80106a82:	c7 80 34 28 11 80 00 	movl   $0xcffa00,-0x7feed7cc(%eax)
80106a89:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a8c:	c7 80 38 28 11 80 ff 	movl   $0xffff,-0x7feed7c8(%eax)
80106a93:	ff 00 00 
80106a96:	c7 80 3c 28 11 80 00 	movl   $0xcff200,-0x7feed7c4(%eax)
80106a9d:	f2 cf 00 
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106aa0:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106aa7:	89 cb                	mov    %ecx,%ebx
80106aa9:	c1 eb 10             	shr    $0x10,%ebx
80106aac:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106ab3:	c1 e9 18             	shr    $0x18,%ecx
80106ab6:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106abc:	bb 92 c0 ff ff       	mov    $0xffffc092,%ebx
80106ac1:	66 89 98 2d 28 11 80 	mov    %bx,-0x7feed7d3(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106ac8:	05 10 28 11 80       	add    $0x80112810,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106acd:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
  pd[0] = size-1;
80106ad3:	b9 37 00 00 00       	mov    $0x37,%ecx
80106ad8:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  pd[1] = (uint)p;
80106adc:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ae0:	c1 e8 10             	shr    $0x10,%eax
80106ae3:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106ae7:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106aea:	0f 01 10             	lgdtl  (%eax)
  asm volatile("movw %0, %%gs" : : "r" (v));
80106aed:	b8 18 00 00 00       	mov    $0x18,%eax
80106af2:	8e e8                	mov    %eax,%gs
  proc = 0;
80106af4:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106afb:	00 00 00 00 
  c = &cpus[cpunum()];
80106aff:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
}
80106b06:	83 c4 14             	add    $0x14,%esp
80106b09:	5b                   	pop    %ebx
80106b0a:	5d                   	pop    %ebp
80106b0b:	c3                   	ret    
80106b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b10 <setupkvm>:
{
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	56                   	push   %esi
80106b14:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106b15:	e8 b6 b9 ff ff       	call   801024d0 <kalloc>
80106b1a:	85 c0                	test   %eax,%eax
80106b1c:	74 52                	je     80106b70 <setupkvm+0x60>
  memset(pgdir, 0, PGSIZE);
80106b1e:	83 ec 04             	sub    $0x4,%esp
80106b21:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106b23:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106b28:	68 00 10 00 00       	push   $0x1000
80106b2d:	6a 00                	push   $0x0
80106b2f:	50                   	push   %eax
80106b30:	e8 9b db ff ff       	call   801046d0 <memset>
80106b35:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0)
80106b38:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106b3b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106b3e:	83 ec 08             	sub    $0x8,%esp
80106b41:	8b 13                	mov    (%ebx),%edx
80106b43:	ff 73 0c             	pushl  0xc(%ebx)
80106b46:	50                   	push   %eax
80106b47:	29 c1                	sub    %eax,%ecx
80106b49:	89 f0                	mov    %esi,%eax
80106b4b:	e8 b0 fd ff ff       	call   80106900 <mappages>
80106b50:	83 c4 10             	add    $0x10,%esp
80106b53:	85 c0                	test   %eax,%eax
80106b55:	78 19                	js     80106b70 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106b57:	83 c3 10             	add    $0x10,%ebx
80106b5a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106b60:	75 d6                	jne    80106b38 <setupkvm+0x28>
}
80106b62:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106b65:	89 f0                	mov    %esi,%eax
80106b67:	5b                   	pop    %ebx
80106b68:	5e                   	pop    %esi
80106b69:	5d                   	pop    %ebp
80106b6a:	c3                   	ret    
80106b6b:	90                   	nop
80106b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106b70:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106b73:	31 f6                	xor    %esi,%esi
}
80106b75:	89 f0                	mov    %esi,%eax
80106b77:	5b                   	pop    %ebx
80106b78:	5e                   	pop    %esi
80106b79:	5d                   	pop    %ebp
80106b7a:	c3                   	ret    
80106b7b:	90                   	nop
80106b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b80 <kvmalloc>:
{
80106b80:	55                   	push   %ebp
80106b81:	89 e5                	mov    %esp,%ebp
80106b83:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106b86:	e8 85 ff ff ff       	call   80106b10 <setupkvm>
80106b8b:	a3 24 56 11 80       	mov    %eax,0x80115624
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b90:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b95:	0f 22 d8             	mov    %eax,%cr3
}
80106b98:	c9                   	leave  
80106b99:	c3                   	ret    
80106b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ba0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ba0:	a1 24 56 11 80       	mov    0x80115624,%eax
{
80106ba5:	55                   	push   %ebp
80106ba6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ba8:	05 00 00 00 80       	add    $0x80000000,%eax
80106bad:	0f 22 d8             	mov    %eax,%cr3
}
80106bb0:	5d                   	pop    %ebp
80106bb1:	c3                   	ret    
80106bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bc0 <switchuvm>:
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	53                   	push   %ebx
80106bc4:	83 ec 04             	sub    $0x4,%esp
80106bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80106bca:	e8 31 da ff ff       	call   80104600 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106bcf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106bd5:	b9 67 00 00 00       	mov    $0x67,%ecx
80106bda:	8d 50 08             	lea    0x8(%eax),%edx
80106bdd:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106be4:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106beb:	89 d1                	mov    %edx,%ecx
80106bed:	c1 ea 18             	shr    $0x18,%edx
80106bf0:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80106bf6:	ba 89 40 00 00       	mov    $0x4089,%edx
80106bfb:	c1 e9 10             	shr    $0x10,%ecx
80106bfe:	66 89 90 a5 00 00 00 	mov    %dx,0xa5(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106c05:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106c0c:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80106c12:	b9 10 00 00 00       	mov    $0x10,%ecx
80106c17:	66 89 48 10          	mov    %cx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106c1b:	8b 52 08             	mov    0x8(%edx),%edx
80106c1e:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106c24:	89 50 0c             	mov    %edx,0xc(%eax)
  cpu->ts.iomb = (ushort) 0xFFFF;
80106c27:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106c2c:	66 89 50 6e          	mov    %dx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106c30:	b8 30 00 00 00       	mov    $0x30,%eax
80106c35:	0f 00 d8             	ltr    %ax
  if(p->pgdir == 0)
80106c38:	8b 43 04             	mov    0x4(%ebx),%eax
80106c3b:	85 c0                	test   %eax,%eax
80106c3d:	74 11                	je     80106c50 <switchuvm+0x90>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106c3f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c44:	0f 22 d8             	mov    %eax,%cr3
}
80106c47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106c4a:	c9                   	leave  
  popcli();
80106c4b:	e9 e0 d9 ff ff       	jmp    80104630 <popcli>
    panic("switchuvm: no pgdir");
80106c50:	83 ec 0c             	sub    $0xc,%esp
80106c53:	68 96 7a 10 80       	push   $0x80107a96
80106c58:	e8 33 97 ff ff       	call   80100390 <panic>
80106c5d:	8d 76 00             	lea    0x0(%esi),%esi

80106c60 <inituvm>:
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 1c             	sub    $0x1c,%esp
80106c69:	8b 75 10             	mov    0x10(%ebp),%esi
80106c6c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c6f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106c72:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106c78:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106c7b:	77 49                	ja     80106cc6 <inituvm+0x66>
  mem = kalloc();
80106c7d:	e8 4e b8 ff ff       	call   801024d0 <kalloc>
  memset(mem, 0, PGSIZE);
80106c82:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106c85:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c87:	68 00 10 00 00       	push   $0x1000
80106c8c:	6a 00                	push   $0x0
80106c8e:	50                   	push   %eax
80106c8f:	e8 3c da ff ff       	call   801046d0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c94:	58                   	pop    %eax
80106c95:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c9b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ca0:	5a                   	pop    %edx
80106ca1:	6a 06                	push   $0x6
80106ca3:	50                   	push   %eax
80106ca4:	31 d2                	xor    %edx,%edx
80106ca6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ca9:	e8 52 fc ff ff       	call   80106900 <mappages>
  memmove(mem, init, sz);
80106cae:	89 75 10             	mov    %esi,0x10(%ebp)
80106cb1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106cb4:	83 c4 10             	add    $0x10,%esp
80106cb7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106cba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cbd:	5b                   	pop    %ebx
80106cbe:	5e                   	pop    %esi
80106cbf:	5f                   	pop    %edi
80106cc0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106cc1:	e9 ba da ff ff       	jmp    80104780 <memmove>
    panic("inituvm: more than a page");
80106cc6:	83 ec 0c             	sub    $0xc,%esp
80106cc9:	68 aa 7a 10 80       	push   $0x80107aaa
80106cce:	e8 bd 96 ff ff       	call   80100390 <panic>
80106cd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ce0 <loaduvm>:
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	57                   	push   %edi
80106ce4:	56                   	push   %esi
80106ce5:	53                   	push   %ebx
80106ce6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106ce9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106cf0:	0f 85 91 00 00 00    	jne    80106d87 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106cf6:	8b 75 18             	mov    0x18(%ebp),%esi
80106cf9:	31 db                	xor    %ebx,%ebx
80106cfb:	85 f6                	test   %esi,%esi
80106cfd:	75 1a                	jne    80106d19 <loaduvm+0x39>
80106cff:	eb 6f                	jmp    80106d70 <loaduvm+0x90>
80106d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d08:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d0e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d14:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d17:	76 57                	jbe    80106d70 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d19:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d1c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d1f:	31 c9                	xor    %ecx,%ecx
80106d21:	01 da                	add    %ebx,%edx
80106d23:	e8 58 fb ff ff       	call   80106880 <walkpgdir>
80106d28:	85 c0                	test   %eax,%eax
80106d2a:	74 4e                	je     80106d7a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106d2c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d2e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106d31:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106d36:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d3b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d41:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d44:	01 d9                	add    %ebx,%ecx
80106d46:	05 00 00 00 80       	add    $0x80000000,%eax
80106d4b:	57                   	push   %edi
80106d4c:	51                   	push   %ecx
80106d4d:	50                   	push   %eax
80106d4e:	ff 75 10             	pushl  0x10(%ebp)
80106d51:	e8 ea ab ff ff       	call   80101940 <readi>
80106d56:	83 c4 10             	add    $0x10,%esp
80106d59:	39 f8                	cmp    %edi,%eax
80106d5b:	74 ab                	je     80106d08 <loaduvm+0x28>
}
80106d5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d65:	5b                   	pop    %ebx
80106d66:	5e                   	pop    %esi
80106d67:	5f                   	pop    %edi
80106d68:	5d                   	pop    %ebp
80106d69:	c3                   	ret    
80106d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d70:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106d73:	31 c0                	xor    %eax,%eax
}
80106d75:	5b                   	pop    %ebx
80106d76:	5e                   	pop    %esi
80106d77:	5f                   	pop    %edi
80106d78:	5d                   	pop    %ebp
80106d79:	c3                   	ret    
      panic("loaduvm: address should exist");
80106d7a:	83 ec 0c             	sub    $0xc,%esp
80106d7d:	68 c4 7a 10 80       	push   $0x80107ac4
80106d82:	e8 09 96 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106d87:	83 ec 0c             	sub    $0xc,%esp
80106d8a:	68 68 7b 10 80       	push   $0x80107b68
80106d8f:	e8 fc 95 ff ff       	call   80100390 <panic>
80106d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106da0 <allocuvm>:
{
80106da0:	55                   	push   %ebp
80106da1:	89 e5                	mov    %esp,%ebp
80106da3:	57                   	push   %edi
80106da4:	56                   	push   %esi
80106da5:	53                   	push   %ebx
80106da6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106da9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106dac:	85 ff                	test   %edi,%edi
80106dae:	0f 88 8e 00 00 00    	js     80106e42 <allocuvm+0xa2>
  if(newsz < oldsz)
80106db4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106db7:	0f 82 93 00 00 00    	jb     80106e50 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106dbd:	8b 45 0c             	mov    0xc(%ebp),%eax
80106dc0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106dc6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106dcc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106dcf:	0f 86 7e 00 00 00    	jbe    80106e53 <allocuvm+0xb3>
80106dd5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106dd8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106ddb:	eb 42                	jmp    80106e1f <allocuvm+0x7f>
80106ddd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106de0:	83 ec 04             	sub    $0x4,%esp
80106de3:	68 00 10 00 00       	push   $0x1000
80106de8:	6a 00                	push   $0x0
80106dea:	50                   	push   %eax
80106deb:	e8 e0 d8 ff ff       	call   801046d0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106df0:	58                   	pop    %eax
80106df1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106df7:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dfc:	5a                   	pop    %edx
80106dfd:	6a 06                	push   $0x6
80106dff:	50                   	push   %eax
80106e00:	89 da                	mov    %ebx,%edx
80106e02:	89 f8                	mov    %edi,%eax
80106e04:	e8 f7 fa ff ff       	call   80106900 <mappages>
80106e09:	83 c4 10             	add    $0x10,%esp
80106e0c:	85 c0                	test   %eax,%eax
80106e0e:	78 50                	js     80106e60 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106e10:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e16:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106e19:	0f 86 81 00 00 00    	jbe    80106ea0 <allocuvm+0x100>
    mem = kalloc();
80106e1f:	e8 ac b6 ff ff       	call   801024d0 <kalloc>
    if(mem == 0){
80106e24:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106e26:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e28:	75 b6                	jne    80106de0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106e2a:	83 ec 0c             	sub    $0xc,%esp
80106e2d:	68 e2 7a 10 80       	push   $0x80107ae2
80106e32:	e8 29 98 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106e37:	83 c4 10             	add    $0x10,%esp
80106e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e3d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106e40:	77 6e                	ja     80106eb0 <allocuvm+0x110>
}
80106e42:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106e45:	31 ff                	xor    %edi,%edi
}
80106e47:	89 f8                	mov    %edi,%eax
80106e49:	5b                   	pop    %ebx
80106e4a:	5e                   	pop    %esi
80106e4b:	5f                   	pop    %edi
80106e4c:	5d                   	pop    %ebp
80106e4d:	c3                   	ret    
80106e4e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106e50:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106e53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e56:	89 f8                	mov    %edi,%eax
80106e58:	5b                   	pop    %ebx
80106e59:	5e                   	pop    %esi
80106e5a:	5f                   	pop    %edi
80106e5b:	5d                   	pop    %ebp
80106e5c:	c3                   	ret    
80106e5d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106e60:	83 ec 0c             	sub    $0xc,%esp
80106e63:	68 fa 7a 10 80       	push   $0x80107afa
80106e68:	e8 f3 97 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106e6d:	83 c4 10             	add    $0x10,%esp
80106e70:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e73:	39 45 10             	cmp    %eax,0x10(%ebp)
80106e76:	76 0d                	jbe    80106e85 <allocuvm+0xe5>
80106e78:	89 c1                	mov    %eax,%ecx
80106e7a:	8b 55 10             	mov    0x10(%ebp),%edx
80106e7d:	8b 45 08             	mov    0x8(%ebp),%eax
80106e80:	e8 0b fb ff ff       	call   80106990 <deallocuvm.part.0>
      kfree(mem);
80106e85:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106e88:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106e8a:	56                   	push   %esi
80106e8b:	e8 90 b4 ff ff       	call   80102320 <kfree>
      return 0;
80106e90:	83 c4 10             	add    $0x10,%esp
}
80106e93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e96:	89 f8                	mov    %edi,%eax
80106e98:	5b                   	pop    %ebx
80106e99:	5e                   	pop    %esi
80106e9a:	5f                   	pop    %edi
80106e9b:	5d                   	pop    %ebp
80106e9c:	c3                   	ret    
80106e9d:	8d 76 00             	lea    0x0(%esi),%esi
80106ea0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106ea3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ea6:	5b                   	pop    %ebx
80106ea7:	89 f8                	mov    %edi,%eax
80106ea9:	5e                   	pop    %esi
80106eaa:	5f                   	pop    %edi
80106eab:	5d                   	pop    %ebp
80106eac:	c3                   	ret    
80106ead:	8d 76 00             	lea    0x0(%esi),%esi
80106eb0:	89 c1                	mov    %eax,%ecx
80106eb2:	8b 55 10             	mov    0x10(%ebp),%edx
80106eb5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106eb8:	31 ff                	xor    %edi,%edi
80106eba:	e8 d1 fa ff ff       	call   80106990 <deallocuvm.part.0>
80106ebf:	eb 92                	jmp    80106e53 <allocuvm+0xb3>
80106ec1:	eb 0d                	jmp    80106ed0 <deallocuvm>
80106ec3:	90                   	nop
80106ec4:	90                   	nop
80106ec5:	90                   	nop
80106ec6:	90                   	nop
80106ec7:	90                   	nop
80106ec8:	90                   	nop
80106ec9:	90                   	nop
80106eca:	90                   	nop
80106ecb:	90                   	nop
80106ecc:	90                   	nop
80106ecd:	90                   	nop
80106ece:	90                   	nop
80106ecf:	90                   	nop

80106ed0 <deallocuvm>:
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ed6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106edc:	39 d1                	cmp    %edx,%ecx
80106ede:	73 10                	jae    80106ef0 <deallocuvm+0x20>
}
80106ee0:	5d                   	pop    %ebp
80106ee1:	e9 aa fa ff ff       	jmp    80106990 <deallocuvm.part.0>
80106ee6:	8d 76 00             	lea    0x0(%esi),%esi
80106ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106ef0:	89 d0                	mov    %edx,%eax
80106ef2:	5d                   	pop    %ebp
80106ef3:	c3                   	ret    
80106ef4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106efa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f00 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	57                   	push   %edi
80106f04:	56                   	push   %esi
80106f05:	53                   	push   %ebx
80106f06:	83 ec 0c             	sub    $0xc,%esp
80106f09:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106f0c:	85 f6                	test   %esi,%esi
80106f0e:	74 59                	je     80106f69 <freevm+0x69>
80106f10:	31 c9                	xor    %ecx,%ecx
80106f12:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f17:	89 f0                	mov    %esi,%eax
80106f19:	e8 72 fa ff ff       	call   80106990 <deallocuvm.part.0>
80106f1e:	89 f3                	mov    %esi,%ebx
80106f20:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f26:	eb 0f                	jmp    80106f37 <freevm+0x37>
80106f28:	90                   	nop
80106f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f30:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f33:	39 fb                	cmp    %edi,%ebx
80106f35:	74 23                	je     80106f5a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f37:	8b 03                	mov    (%ebx),%eax
80106f39:	a8 01                	test   $0x1,%al
80106f3b:	74 f3                	je     80106f30 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f3d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106f42:	83 ec 0c             	sub    $0xc,%esp
80106f45:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f48:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106f4d:	50                   	push   %eax
80106f4e:	e8 cd b3 ff ff       	call   80102320 <kfree>
80106f53:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106f56:	39 fb                	cmp    %edi,%ebx
80106f58:	75 dd                	jne    80106f37 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106f5a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f60:	5b                   	pop    %ebx
80106f61:	5e                   	pop    %esi
80106f62:	5f                   	pop    %edi
80106f63:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106f64:	e9 b7 b3 ff ff       	jmp    80102320 <kfree>
    panic("freevm: no pgdir");
80106f69:	83 ec 0c             	sub    $0xc,%esp
80106f6c:	68 16 7b 10 80       	push   $0x80107b16
80106f71:	e8 1a 94 ff ff       	call   80100390 <panic>
80106f76:	8d 76 00             	lea    0x0(%esi),%esi
80106f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f80 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f80:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f81:	31 c9                	xor    %ecx,%ecx
{
80106f83:	89 e5                	mov    %esp,%ebp
80106f85:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106f88:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f8e:	e8 ed f8 ff ff       	call   80106880 <walkpgdir>
  if(pte == 0)
80106f93:	85 c0                	test   %eax,%eax
80106f95:	74 05                	je     80106f9c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106f97:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106f9a:	c9                   	leave  
80106f9b:	c3                   	ret    
    panic("clearpteu");
80106f9c:	83 ec 0c             	sub    $0xc,%esp
80106f9f:	68 27 7b 10 80       	push   $0x80107b27
80106fa4:	e8 e7 93 ff ff       	call   80100390 <panic>
80106fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fb0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106fb9:	e8 52 fb ff ff       	call   80106b10 <setupkvm>
80106fbe:	85 c0                	test   %eax,%eax
80106fc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106fc3:	0f 84 a0 00 00 00    	je     80107069 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fc9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106fcc:	85 c9                	test   %ecx,%ecx
80106fce:	0f 84 95 00 00 00    	je     80107069 <copyuvm+0xb9>
80106fd4:	31 f6                	xor    %esi,%esi
80106fd6:	eb 4e                	jmp    80107026 <copyuvm+0x76>
80106fd8:	90                   	nop
80106fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106fe0:	83 ec 04             	sub    $0x4,%esp
80106fe3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106fe9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106fec:	68 00 10 00 00       	push   $0x1000
80106ff1:	57                   	push   %edi
80106ff2:	50                   	push   %eax
80106ff3:	e8 88 d7 ff ff       	call   80104780 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106ff8:	58                   	pop    %eax
80106ff9:	5a                   	pop    %edx
80106ffa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106ffd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107000:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107005:	53                   	push   %ebx
80107006:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010700c:	52                   	push   %edx
8010700d:	89 f2                	mov    %esi,%edx
8010700f:	e8 ec f8 ff ff       	call   80106900 <mappages>
80107014:	83 c4 10             	add    $0x10,%esp
80107017:	85 c0                	test   %eax,%eax
80107019:	78 39                	js     80107054 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
8010701b:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107021:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107024:	76 43                	jbe    80107069 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107026:	8b 45 08             	mov    0x8(%ebp),%eax
80107029:	31 c9                	xor    %ecx,%ecx
8010702b:	89 f2                	mov    %esi,%edx
8010702d:	e8 4e f8 ff ff       	call   80106880 <walkpgdir>
80107032:	85 c0                	test   %eax,%eax
80107034:	74 3e                	je     80107074 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
80107036:	8b 18                	mov    (%eax),%ebx
80107038:	f6 c3 01             	test   $0x1,%bl
8010703b:	74 44                	je     80107081 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
8010703d:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010703f:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80107045:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
8010704b:	e8 80 b4 ff ff       	call   801024d0 <kalloc>
80107050:	85 c0                	test   %eax,%eax
80107052:	75 8c                	jne    80106fe0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107054:	83 ec 0c             	sub    $0xc,%esp
80107057:	ff 75 e0             	pushl  -0x20(%ebp)
8010705a:	e8 a1 fe ff ff       	call   80106f00 <freevm>
  return 0;
8010705f:	83 c4 10             	add    $0x10,%esp
80107062:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107069:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010706c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010706f:	5b                   	pop    %ebx
80107070:	5e                   	pop    %esi
80107071:	5f                   	pop    %edi
80107072:	5d                   	pop    %ebp
80107073:	c3                   	ret    
      panic("copyuvm: pte should exist");
80107074:	83 ec 0c             	sub    $0xc,%esp
80107077:	68 31 7b 10 80       	push   $0x80107b31
8010707c:	e8 0f 93 ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
80107081:	83 ec 0c             	sub    $0xc,%esp
80107084:	68 4b 7b 10 80       	push   $0x80107b4b
80107089:	e8 02 93 ff ff       	call   80100390 <panic>
8010708e:	66 90                	xchg   %ax,%ax

80107090 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107090:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107091:	31 c9                	xor    %ecx,%ecx
{
80107093:	89 e5                	mov    %esp,%ebp
80107095:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107098:	8b 55 0c             	mov    0xc(%ebp),%edx
8010709b:	8b 45 08             	mov    0x8(%ebp),%eax
8010709e:	e8 dd f7 ff ff       	call   80106880 <walkpgdir>
  if((*pte & PTE_P) == 0)
801070a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801070a5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801070a6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801070a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801070ad:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801070b0:	05 00 00 00 80       	add    $0x80000000,%eax
801070b5:	83 fa 05             	cmp    $0x5,%edx
801070b8:	ba 00 00 00 00       	mov    $0x0,%edx
801070bd:	0f 45 c2             	cmovne %edx,%eax
}
801070c0:	c3                   	ret    
801070c1:	eb 0d                	jmp    801070d0 <copyout>
801070c3:	90                   	nop
801070c4:	90                   	nop
801070c5:	90                   	nop
801070c6:	90                   	nop
801070c7:	90                   	nop
801070c8:	90                   	nop
801070c9:	90                   	nop
801070ca:	90                   	nop
801070cb:	90                   	nop
801070cc:	90                   	nop
801070cd:	90                   	nop
801070ce:	90                   	nop
801070cf:	90                   	nop

801070d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	53                   	push   %ebx
801070d6:	83 ec 1c             	sub    $0x1c,%esp
801070d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801070dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801070df:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801070e2:	85 db                	test   %ebx,%ebx
801070e4:	75 40                	jne    80107126 <copyout+0x56>
801070e6:	eb 70                	jmp    80107158 <copyout+0x88>
801070e8:	90                   	nop
801070e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801070f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801070f3:	89 f1                	mov    %esi,%ecx
801070f5:	29 d1                	sub    %edx,%ecx
801070f7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801070fd:	39 d9                	cmp    %ebx,%ecx
801070ff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107102:	29 f2                	sub    %esi,%edx
80107104:	83 ec 04             	sub    $0x4,%esp
80107107:	01 d0                	add    %edx,%eax
80107109:	51                   	push   %ecx
8010710a:	57                   	push   %edi
8010710b:	50                   	push   %eax
8010710c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010710f:	e8 6c d6 ff ff       	call   80104780 <memmove>
    len -= n;
    buf += n;
80107114:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107117:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010711a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107120:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107122:	29 cb                	sub    %ecx,%ebx
80107124:	74 32                	je     80107158 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107126:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107128:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010712b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010712e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107134:	56                   	push   %esi
80107135:	ff 75 08             	pushl  0x8(%ebp)
80107138:	e8 53 ff ff ff       	call   80107090 <uva2ka>
    if(pa0 == 0)
8010713d:	83 c4 10             	add    $0x10,%esp
80107140:	85 c0                	test   %eax,%eax
80107142:	75 ac                	jne    801070f0 <copyout+0x20>
  }
  return 0;
}
80107144:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107147:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010714c:	5b                   	pop    %ebx
8010714d:	5e                   	pop    %esi
8010714e:	5f                   	pop    %edi
8010714f:	5d                   	pop    %ebp
80107150:	c3                   	ret    
80107151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107158:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010715b:	31 c0                	xor    %eax,%eax
}
8010715d:	5b                   	pop    %ebx
8010715e:	5e                   	pop    %esi
8010715f:	5f                   	pop    %edi
80107160:	5d                   	pop    %ebp
80107161:	c3                   	ret    
