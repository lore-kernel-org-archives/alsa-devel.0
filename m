From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Gitcompile for Kernel 3.2?
Date: Tue, 7 Aug 2012 10:24:54 +0000
Message-ID: <35FE09CFAB387A4BA7ACDDED49F345181D19CC@CRETE.nmmu.ac.za>
References: <35FE09CFAB387A4BA7ACDDED49F345181D00D8@CRETE.nmmu.ac.za>
 <s5h3940mpcd.wl%tiwai@suse.de>
 <35FE09CFAB387A4BA7ACDDED49F345181D0496@CRETE.nmmu.ac.za>,
 <s5hzk68hy3l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osiris.nmmu.ac.za (osiris.nmmu.ac.za [196.21.198.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 54A3426036F
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 11:55:36 +0200 (CEST)
In-Reply-To: <s5hzk68hy3l.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

1000 apologies for my noob-ness, but I'm still not getting it.  I think I u=
nderstand why it can't be expected to work as is, but I don't know how best=
 to proceed.
> That is, prepare both alsa-driver-build.git and sound.git trees in the
> same directory.  Then run ./gitcompile without ALSAKERNELDIR.
Please help me understand what is meant by 'prepare'.  Does this refer to a=
 make step, or copying files from the appropriate kernel source, or... ?  I=
 haven't been able to clone sound.git either (I get "RPC failed - result=3D=
18" and 'protocol error: bad pack header', though alsa-driver-build clones =
just fine), so I'm assuming it's similar to kmirror.git?  If alsa-driver-bu=
ild is specific to 3.6 (Is that what was implied?), then what modifications=
 would typically be required?  And as stupid as this sounds, I'm not entire=
ly sure I understand what is meant by "same directory"!  alsa-driver-build =
and sound next to each other, or sound inside alsa-driver-build?  Again, my=
 profuse apologies for being the "weakest link"!  Thank you for your patien=
ce=85

________________________________

NOTICE: Please note that this eMail, and the contents thereof, is subject t=
o the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
