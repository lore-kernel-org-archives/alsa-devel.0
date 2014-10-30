From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Build error on Fedora 21
Date: Thu, 30 Oct 2014 12:41:39 +0100
Message-ID: <545223F3.4090005@ladisch.de>
References: <54521CB8.7010201@inf.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 778C626549C
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:41:40 +0100 (CET)
In-Reply-To: <54521CB8.7010201@inf.ed.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark van Rossum <mvanross@inf.ed.ac.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark van Rossum wrote:
> make[1]: Entering directory '/usr/src/kernels/3.17.0-301.fc21.x86_64'
>   CC [M] /tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/acore/info.o

Why are you trying to replace your kernel's drivers with an older version?


Regards,
Clemens
