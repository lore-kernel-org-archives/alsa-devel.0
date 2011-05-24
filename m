From: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Subject: Re: GR-55 Driver
Date: Tue, 24 May 2011 11:28:50 -0700
Message-ID: <1306261730.4965.36.camel@TrinaryDragon>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTinmnzEpRspYb74edaH1q8NPqXZg5w@mail.gmail.com>
	<1305839384.4443.41.camel@TrinaryDragon>
	<201105231701.59052.maillist@superlative.org>
	<BANLkTimLXguMfjj28Ntk8fVHvmVoxf=iWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 43FE210386A
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 20:28:54 +0200 (CEST)
Received: by gwj17 with SMTP id 17so3034731gwj.38
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 11:28:52 -0700 (PDT)
In-Reply-To: <BANLkTimLXguMfjj28Ntk8fVHvmVoxf=iWg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, "Keith A. Milner" <maillist@superlative.org>
List-Id: alsa-devel@alsa-project.org

Its clear you need to have access to the Hardware you are writing the
driver for, so to that end, I decided to try to get you the Hardware and
Funds required to make this happen; this is my plan so far:

I started a Forum here http://mylinuxmachine.com/forum/8 
I had an idea to raise money for Hardware, as well as funds to support
the Developers, I only have one Shopping Cart setup; so I put it here:
http://lightwizzard.com/hardware.html 
http://lightwizzard.com/hardware/gr-55.html

I don't know if this will fly; but if it does, I'll get the hardware and
have it shipped to someone that wants to work on this Driver, a long
with any funds I collect; if this works good; I'll add more hardware
pages as requested. 

If this does work I'll add a shopping cart to MyLinuxMachine and move
the project there, I don't have the funds to do it now, or I would have;
a lot more thought needs to be put into this; but its a start. If you
have any suggestions let me know.

The Donation page at ALSA
http://www.alsa-project.org/main/index.php/AlsaProject:Site_support
is blank, so I had to find another way to raise money for you, and this
is the only thing I could think of.

Without Hardware and Money; its not really possible to continue to write
drivers for Hardware you do not have; I hope this is the beginning of
something that works good for everyone. I don't see any other way of
doing this at this point in time.

Jeff

-----Original Message-----
From: Daniel Mack <zonque@gmail.com>
To: Keith A. Milner <maillist@superlative.org>
Cc: alsa-devel@alsa-project.org, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com>
Subject: Re: [alsa-devel] GR-55 Driver
Date: Mon, 23 May 2011 19:08:09 +0200

On Mon, May 23, 2011 at 6:01 PM, Keith A. Milner
<maillist@superlative.org> wrote:

> On the other hand, the quirk entries for GT-10 and JS-8 are very close to
> being identical. I wonder if the GR-55 needs some specific .data like the GT-10
> does. It may be worth taking the GT-10 entry and changing it for the GR-55
> vid/pid and trying it.

I took the JS-8 quirks as a starting point because the USB descriptor
dumps looked identical to me. But I could have overlooked a detail,
that's possible. So as you've worked with such devices before, if you
could double-check and give some info, that would be a great help.
Without access to such (even similar) hardware, it's hard to really
help much.


Thanks,
Daniel
