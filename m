From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: NV Soundstorm support? / Recording broke!
Date: Mon, 23 Jun 2003 19:43:20 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF6D9C8.8010805@boosthardware.com>
References: <20030623093405.22415.qmail@web9204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel MacDonald <danboid@yahoo.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Daniel MacDonald wrote:
> 
> I've been thinking of starting a petition as I'm sick
> of waiting for this. 
> 

Good idea.

> The main reason for my building impatience is as Mr.
> PBD said that he's have that long, long, LONG awaited
> Ardour rc out by now- what happened Paul? We expect
> release candidates to have bugs- as long as it
> compiles under the major distros that'll be enough.
> Bring forth that glorious tarball pleeze!
> 

The beta is being tested now and when that is ready the rc will probably 
be released.

> Anyway, I have installed ALSA 0.9.4 on Redhat 9 XFS
> and although sound output works fine, recording (both
> line in and mic) doesn't want to work at all (under
> Audacity CVS, but I tried it with the GNOME sound
> recorder too). I did get recording to work on this
> same machine but when I was running Mandrake 9.1 and
> ALSA 0.9.3. Has anybody else reported/ solved this
> problem?
> 

Never seen it but you should try using alsamixer and arecord/aplay. 
There is a howto via the quicktoots project at the LAU guide (see below).

> I tried downloading the latest alsa-driver CVS but for
> some reason it refused to download past the patches
> bit and it was complaining about some ALSAKERNEL stuff
> so I just gave up with that.
> 

The tarballs are working AFAIK. Did you use the ones from alsa-project.org?


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
