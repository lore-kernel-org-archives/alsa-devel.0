From: Daniel MacDonald <danboid@yahoo.co.uk>
Subject: NV Soundstorm support? / Recording broke!
Date: Mon, 23 Jun 2003 02:34:05 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030623093405.22415.qmail@web9204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello ALSA devs!

My biggest question is- what is going on with Linux
support for NVIDIA's NFORCE 2/ Soundstorm chipset?
Have NVIDIA been contributing code or patches to ALSA
or has the ALSA driver been created independently?
More importantly, how long before we see PROPER
support for the soundstorm under ALSA, instead of just
a hacked intel8x0 driver? I want multiple dsp channels
and 24-bit audio I/O under Linux please NVIDIA!

I've been thinking of starting a petition as I'm sick
of waiting for this. They release new Linux drivers
for their GFX cards every other week so why can't (at
least temporarily) devote some of their Linux
workforce into getting Soundstorm support under ALSA
sorted?

The main reason for my building impatience is as Mr.
PBD said that he's have that long, long, LONG awaited
Ardour rc out by now- what happened Paul? We expect
release candidates to have bugs- as long as it
compiles under the major distros that'll be enough.
Bring forth that glorious tarball pleeze!

Anyway, I have installed ALSA 0.9.4 on Redhat 9 XFS
and although sound output works fine, recording (both
line in and mic) doesn't want to work at all (under
Audacity CVS, but I tried it with the GNOME sound
recorder too). I did get recording to work on this
same machine but when I was running Mandrake 9.1 and
ALSA 0.9.3. Has anybody else reported/ solved this
problem?

I tried downloading the latest alsa-driver CVS but for
some reason it refused to download past the patches
bit and it was complaining about some ALSAKERNEL stuff
so I just gave up with that.

Hopefully somebody will be able to answer at least
part of this multi-faceted whine-fest of a mail.

Thanks v. much!

dan

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
