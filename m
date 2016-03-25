From: Jef <groupentity@comcast.net>
Subject: Re: writing driver for MOTU PCI 324, 2408 MK-II
Date: Fri, 25 Mar 2016 15:12:24 +0000 (UTC)
Message-ID: <loom.20160325T160057-569@post.gmane.org>
References: <20050508161425.GD25855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 06D8B26066B
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2016 18:35:06 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1ajVdY-0004si-Sa
 for alsa-devel@alsa-project.org; Fri, 25 Mar 2016 18:35:05 +0100
Received: from c-98-232-226-229.hsd1.or.comcast.net ([98.232.226.229])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2016 18:35:04 +0100
Received: from groupentity by c-98-232-226-229.hsd1.or.comcast.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2016 18:35:04 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Forest Bond <f_a_b <at> softhome.net> writes:

> 
> Hello all,
> 
> I'm new to the list.  Joined up because I've decided I want to write a 
> driver for the Mark of the Unicorn PCI-324 PCI card.  This card allows a 
> variety of MOTU external interfaces to be used.  I own a MOTU 2408 MK 
> II, an 8 channel interface.  This (and similar interfaces from MOTU) are 
> common in the pro audio world.
> 
> I have emailed MOTU tech support, but have not gotten a response.  I 
> have a feeling this will be the case in the future, as well.  MOTU has 
> strong ties with Apple.
> 
> I've searched the list archive, and, from what I can see, noone has 
> begun work on a driver for these interfaces.  It may not be feasible, 
> given the lack of technical information available (yeah, yeah, I know, 
> welcome to the wonderful world of linux driver development).  If, 
> however, anyone is aware of an attempt to write a driver, please let me 
> know.  Also, if anyone is interested in pitching in, send me an email.
> 
> I have limited experience writing drivers (well, next to none, 
> actually), but I'm gonna give it a shot anyway.
> 
> Couple of questions:
> 
> Can released ASIO drivers be used to gather technical information on the 
> hardware?
> 
> Are there any good techniques for probing the hardware and discovering 
> necessary technical info?
> 
> Any help would be appreciated.
> 
> Thanks!
> Forest
> 

Hello!
I know this is an old post, but I was hoping that the sentiment was still
alive and strong. I have recently made the transition to Linux as my primary
OS, and I, too, am looking to move my audio gear along as well. Has there
been any progress on the PCI-324 linux driver development front? Is there an
active project in the works, or has this idea been abandoned?
Cheers! And thank you.
Jef
