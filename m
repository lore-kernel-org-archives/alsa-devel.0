From: Pap Peti <roachkiller44@gmail.com>
Subject: Re: M-audio Audiophile Firewire
Date: Tue, 1 Nov 2016 14:54:39 +0100
Message-ID: <7e765437-91b7-9ea3-c9d8-e97d8fb4f100@gmail.com>
References: <CAPzTivG=yDAbFZo+u5qauE_LdpqhUM5fT9MT9+hrmi3gTsTGqw@mail.gmail.com>
 <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
 <fd56b817-96b3-1784-725c-21a5bef7497a@sakamocchi.jp>
 <CAPzTivEubUhef5LR_p3y0_4TZtbwoLimvzU-tx=xmUhBnT+T0g@mail.gmail.com>
 <CAPzTivHypNMZvBVBks=wpx1XakELyeWsBVD9mpq-risb_DtH=Q@mail.gmail.com>
 <7f5bc2fc-7e45-2577-9286-be0e2ff74228@sakamocchi.jp>
 <CAPzTivHqY1aBH2hqHetmd7-hdZsPbPsC8e1iMjgL=2myH91fbg@mail.gmail.com>
 <a2d308f4-1982-8418-40ec-e783065f7a96@sakamocchi.jp>
 <CAPzTivFtjdmpEOYJo=a=B12_Zf9UVV+SjRUKA9hNWLop3w5nbg@mail.gmail.com>
 <CAPzTivEPwnerkvH-Y5j9bvGzsM5GhLKvF69zFAkVHpDt-8g1Lw@mail.gmail.com>
 <20161023224350.GB12315@marvin.atrad.com.au>
 <5951c05f-3fe4-a2fc-aab2-407fddf8a817@gmail.com>
 <6f6374d3-f616-0d9d-31ac-2d463573f889@sakamocchi.jp>
 <80a6876e-6ced-7daa-7268-1277850c8270@gmail.com>
 <f677dfd1-c67d-7669-f4d4-d0dd5d8ff99e@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 439F0266E1D
 for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2016 14:54:42 +0100 (CET)
Received: by mail-wm0-f53.google.com with SMTP id n67so287487833wme.1
 for <alsa-devel@alsa-project.org>; Tue, 01 Nov 2016 06:54:42 -0700 (PDT)
In-Reply-To: <f677dfd1-c67d-7669-f4d4-d0dd5d8ff99e@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Jonathan Woithe <jwoithe@just42.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Okay,

Now I went back to Linux Mint Sarah (18) with Cinnamon window manager (x64)

MY HW:

H/W path         Device      Class          Description 
======================================================= 
                              system         Computer 
/0                           bus            Motherboard 
/0/0                         memory         3834MiB System memory 
/0/1                         processor      Intel(R) Core(TM) i5-2520M 
CPU @ 2.5 /0/100                       bridge         2nd Generation 
Core Processor Family /0/100/2                     display        2nd 
Generation Core Processor Family /0/100/16                    
communication  6 Series/C200 Series Chipset Family 
/0/100/16.3                  communication  6 Series/C200 Series Chipset 
Family /0/100/19        enp0s25     network        82579LM Gigabit 
Network Connection /0/100/1a                    bus            6 
Series/C200 Series Chipset Family /0/100/1b                    
multimedia     6 Series/C200 Series Chipset Family 
/0/100/1c                    bridge         6 Series/C200 Series Chipset 
Family /0/100/1c.1                  bridge         6 Series/C200 Series 
Chipset Family /0/100/1c.1/0    wlp3s0      network        Centrino 
Advanced-N 6205 [Taylor Pea /0/100/1c.3                  bridge         
6 Series/C200 Series Chipset Family /0/100/1c.3/0                
bridge         XIO2000(A)/XIO2200A PCI Express-to-P 
/0/100/1c.3/0/0              bus            XIO2200A IEEE-1394a-2000 
Controller /0/100/1c.4                  bridge         6 Series/C200 
Series Chipset Family /0/100/1c.4/0                generic        MMC/SD 
Host Controller /0/100/1d                    bus            6 
Series/C200 Series Chipset Family /0/100/1f                    
bridge         QM67 Express Chipset Family LPC Cont 
/0/100/1f.2                  storage        6 Series/C200 Series Chipset 
Family /0/100/1f.3                  bus            6 Series/C200 Series 
Chipset Family /0/2             scsi1       storage /0/2/0.0.0       
/dev/cdrom  disk           DVDRAM GT50N

and:

Linux 4.4.0-45-generic x86_64

ffado-dbus-ser 2:2.2.1+svn2

ffado-mixer

DAW: Tracktion 5 (x64) /if I use with ALSA driver, I cant play sounds 
paralell with another applications e.g.: browser - youtube, or any player)

And I cant connect JACK firewire backend with realtime priority.

"

14:51:17.044 D-BUS: JACK server could not be started. Sorry

Cannot connect to server socket err = No such file or directory

Cannot connect to server request channel

jack server is not running or cannot be started

JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
skipping unlock

JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
skipping unlock

Tue Nov 1 14:51:16 2016: Starting jack server...

Tue Nov 1 14:51:16 2016: JACK server starting in realtime mode with 
priority 10

Tue Nov 1 14:51:16 2016: self-connect-mode is "Don't restrict self 
connect requests"

Tue Nov 1 14:51:16 2016: ERROR: Cannot lock down 107341338 byte memory 
area (Cannot allocate memory)

Tue Nov 1 14:51:17 2016: ERROR: firewire ERR: FFADO: Error creating 
virtual device

Tue Nov 1 14:51:17 2016: ERROR: Cannot attach audio driver

Tue Nov 1 14:51:17 2016: ERROR: JackServer::Open failed with -1

Tue Nov 1 14:51:17 2016: ERROR: Failed to open server

Tue Nov 1 14:51:19 2016: Saving settings to 
"/home/delest/.config/jack/conf.xml" ...

14:51:25.334 Could not connect to JACK server as client. - Overall 
operation failed. - Unable to connect to server. Please check the 
messages window for more info.

Cannot connect to server socket err = No such file or directory

Cannot connect to server request channel

jack server is not running or cannot be started

JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
skipping unlock

JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
skipping unlock*"*

So, I think maybe the JACK make me less CPU usage in the DAW , and/or I 
can play sound from another source too, in each time. But if I can solve 
theese problems with ALSA, thats also okay for me :) Regards Peti
On 10/28/2016 03:30 AM, Takashi Sakamoto wrote:
> On Oct 27 2016 23:10, Pap Peti wrote:
>> My controller: *-firewire                    description: FireWire 
>> (IEEE 1394)                    product: XIO2200A IEEE-1394a-2000 
>> Controller (PHY/Link)                    vendor: Texas Instruments 
>>                    physical id: 0                    bus info: 
>> pci@0000:06:00.0                    version: 01                    
>> width: 32 bits                    clock: 66MHz                    
>> capabilities: ohci bus_master cap_list                    
>> configuration: driver=firewire_ohci latency=32 maxlatency=4 mingnt=2 
>>                    resources: irq:19 memory:f1c04000-f1c047ff 
>> memory:f1c00000-f1c03fff 
> Not enough to re-generate your issue in my hand. Please inform below 
> information to me:  - applications in your test  - operations in your 
> test  - the environment of your test; distribution, kernel version, 
> and so on Regards Takashi Sakamoto 
