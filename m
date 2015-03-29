From: Damien Zammit <damien@zamaudio.com>
Subject: Re: [RFC v2][PATCH 00/11] digi00x: new driver for
 Digidesign 002/003 family
Date: Mon, 30 Mar 2015 03:45:31 +1100
Message-ID: <55182C2B.5000307@zamaudio.com>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
 <551815D7.80602@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 58ACF26047C
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 18:45:41 +0200 (CEST)
Received: by pdcp1 with SMTP id p1so58819174pdc.3
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 09:45:39 -0700 (PDT)
In-Reply-To: <551815D7.80602@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, robin@gareus.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi folks,

I tested Takashi's latest commit 502849718c70ed0b from github on my
003Rack+ and the driver works.  I also confirm there is no hissing noise
on any channels with this driver so 003amdtp is correctly implemented.

Good job Takashi, is there any way we can push forward to get it upstream?

Damien

On 30/03/15 02:10, Takashi Sakamoto wrote:
> On Mar 30 2015 00:05, Takashi Sakamoto wrote:
>> Well, I'll stop my work for this driver in this developing period
>> (for Linux 4.0),
> 
> Oops. '(for Linux 4.1)' is correct...
> 
> 
> Regards
> 
> Takashi Sakamoto
> 
