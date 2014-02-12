From: Bernhard <schlimmchen@yahoo.de>
Subject: Re: No sound from Headphone Jack over Lenovo Docking
	Station with T440p Laptop
Date: Wed, 12 Feb 2014 21:01:09 +0000 (UTC)
Message-ID: <loom.20140212T215407-567@post.gmane.org>
References: <trinity-ed805987-a2af-445d-8c84-171681bd6482-1387447530146@3capp-webde-bs34>
 <CAN8cciaKv=4s2Njaag7XjqBj203EPL1BTi3XAG+ZmEpSP+20hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA34264EF5
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 22:05:05 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WDgzP-0003ZG-V3
 for alsa-devel@alsa-project.org; Wed, 12 Feb 2014 22:05:04 +0100
Received: from dslb-088-076-060-135.pools.arcor-ip.net ([88.76.60.135])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 22:05:03 +0100
Received: from schlimmchen by dslb-088-076-060-135.pools.arcor-ip.net with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 22:05:03 +0100
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

Raymond Yau <superquad.vortex2 <at> gmail.com> writes:
> 
> Post the output of alsa-info.sh when thinkpad is docked and not docked with
> headphone pluggedd and unplugged
> 

I created the output you requested (Lenovo ThinkPad T440p in UltraDock, no 
sound when docked via dock jack but notebook speakers are also mute).

not docked: http://pastebin.com/MFQT3R9S
docked, no headphones: http://pastebin.com/8UN1sHSM
docked, headphones plugged in dock: http://pastebin.com/7XauZLZz
docked, headphones plugged in notebook: http://pastebin.com/xfL5qkge

Based on that, can you help us getting sound to work on the dock?

Best,
Bernhard
