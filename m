From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: BugReport: Dice works partially [Broken]
Date: Mon, 06 Apr 2015 22:14:47 +0200
Message-ID: <5522E937.8030405@ladisch.de>
References: <CAPv3Zfxaw9ZEBd_JjCoHjHC=xxJyEpG+dLHpB-vrmNCms=0uRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C5052260494
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2015 22:15:01 +0200 (CEST)
In-Reply-To: <CAPv3Zfxaw9ZEBd_JjCoHjHC=xxJyEpG+dLHpB-vrmNCms=0uRQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stanislav Sergiienko <pythonpowerd@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Stanislav Sergiienko wrote:
> Hi, I am a user of TC Electronic DesktopKonnekt6 and latest kernel
> update 3.19.2 add partial support for my device and thus broke my
> usual sound workflow. So i want to make good bug report to make device
> usable on latest kernels.
>
> With 3.19.2 kernel device is successfully recognized by system and
> even sometimes can play sound(!).

What exactly happens when it cannot play sound?

> But always, after some time sound is breaks (usually after 30-90
> seconds) and to restore it i must restart pulseaudio(v6.0) and
> application.

What exactly happens when it "breaks"?
Any error messages in the system log?


Regards,
Clemens
