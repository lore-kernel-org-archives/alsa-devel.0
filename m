From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with alsa-compile.sh script on Linux Mint
 18.1
Date: Wed, 18 Jan 2017 18:10:11 +0100
Message-ID: <21841786-a8c4-bf40-71bb-2d539419fdf2@ladisch.de>
References: <CAFdEiKRNhyFEiKCxm4AktOY+zCFr1uQ8gYfSm=WEmBiv+9bQmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id EA1992676F2
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 18:10:51 +0100 (CET)
In-Reply-To: <CAFdEiKRNhyFEiKCxm4AktOY+zCFr1uQ8gYfSm=WEmBiv+9bQmg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nali Waterfall <nwfalls@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nali Waterfall wrote:
> trying to run alsa-compile.sh script.

The alsa-driver package is outdated.

The ALSA drivers are part of the kernel.  If you need a newer version,
update the kernel package, or recompile the kernel.


Regards,
Clemens
