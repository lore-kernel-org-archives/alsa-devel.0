From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Adding a "capture" device naming scheme
Date: Wed, 12 Jan 2011 09:04:04 +0000
Message-ID: <igjqq3$hds$1@dough.gmane.org>
References: <igi861$q8o$1@dough.gmane.org>
	<AANLkTinBnEj8570w96cy0CQ6+TmzrvTu6uBZQegs10CP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DF5F24474
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 10:04:23 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pcwcq-0000JX-Lh
	for alsa-devel@alsa-project.org; Wed, 12 Jan 2011 10:04:16 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 10:04:16 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 10:04:16 +0100
In-Reply-To: <AANLkTinBnEj8570w96cy0CQ6+TmzrvTu6uBZQegs10CP@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Raymond Yau at 12/01/11 08:53 did gyre and gimble:
> 2011/1/12 Colin Guthrie <gmane@colin.guthr.ie>
> 
>> Hi,
>>
>> As has been pointed out a few times, it's incorrect to use "front:" for
>> capture, but can we have an official name/wrapper (I'm unsure of the
>> terminology here) for this so we don't use hw: for recording?
>>
>>
> My sb live! platinum when using "mono profile" which use  "hw:0" does not
> output any sound
> 
> it seem that emu10k1 have to use "front:0" for playing mono

What has playback got to do with this?

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
