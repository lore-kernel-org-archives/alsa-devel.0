From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] alsactl crashes on 1.0.18rc3 alsa-utils
Date: Wed, 17 Sep 2008 00:29:50 +0100
Message-ID: <gapfhe$33v$2@ger.gmane.org>
References: <gak3n7$rgg$1@ger.gmane.org> <s5h7i9cge7c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id E773D2447F
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 01:30:07 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Kfjze-0001GS-Te
	for alsa-devel@alsa-project.org; Tue, 16 Sep 2008 23:30:02 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2008 23:30:02 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2008 23:30:02 +0000
In-Reply-To: <s5h7i9cge7c.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Sun, 14 Sep 2008 23:37:27 +0100,
> Colin Guthrie wrote:
>> Hi,
>>
>> One of my Mandriva colleagues (Gustavo De Nardin) fixed this in the 
>> following patch:
>> http://svn.mandriva.com/cgi-bin/viewvc.cgi/packages/cooker/alsa-utils/current/SOURCES/alsa-utils-1.0.18rc3-mdv-alsactl_segfault.patch?revision=HEAD&view=markup
> 
> Thanks.  This was already fixed in the latest git.

I thought that may have been the case, but thought I'd better report it 
to be safe :)

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
