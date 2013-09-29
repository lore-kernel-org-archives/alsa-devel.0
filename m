From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Microphone does not longer work on Lenovo N581
Date: Sun, 29 Sep 2013 10:13:34 +0200
Message-ID: <l28nen$jns$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6011E2615A6
 for <alsa-devel@alsa-project.org>; Sun, 29 Sep 2013 10:15:09 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1VQC9g-0002Vv-5F
 for alsa-devel@alsa-project.org; Sun, 29 Sep 2013 10:15:04 +0200
Received: from p54947dc7.dip0.t-ipconnect.de ([84.148.125.199])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 29 Sep 2013 10:15:04 +0200
Received: from Manuel.Spam by p54947dc7.dip0.t-ipconnect.de with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 29 Sep 2013 10:15:04 +0200
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

Hello,

I'm using Archlinux and so usually run always on the latest kernel.

But unfortunately somewhere with Kernel 3.9 my Intel sound got broken. 
Playback works, but no microphone is found.

So I keep downgrading to 3.8.8 for some months, now.

Can someone please help me with finding a solution for this? Is it 
really possible that the alsa driver "snd_had_intel" was broken between 
3.8 and 3.9 and noone found this bug, so far?

Thank you very much in advance

Greetings,

Manuel
