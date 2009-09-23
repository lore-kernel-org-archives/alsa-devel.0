From: Liviu Andronic <landronimirc@gmail.com>
Subject: Re: sound issues on an HP Pavilion DV3-1075 (solved)
Date: Wed, 23 Sep 2009 14:06:53 +0100
Message-ID: <68b1e2610909230606r6fc4b51ev8d9173fa4fa190b5@mail.gmail.com>
References: <68b1e2610909220419j2cd1d86eu97a8f3202fa907be@mail.gmail.com>
	<68b1e2610909220421o77cc27fbg9597aa638c16c919@mail.gmail.com>
	<68b1e2610909230055r603e46em3e18aca9ad566078@mail.gmail.com>
	<604760770909230311o2aeb8ecfu4aa8707bce334610@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 27CF21037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 15:06:54 +0200 (CEST)
Received: by ewy25 with SMTP id 25so668154ewy.45
	for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2009 06:06:53 -0700 (PDT)
In-Reply-To: <604760770909230311o2aeb8ecfu4aa8707bce334610@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/23/09, Daniel Chen <seven.steps@gmail.com> wrote:
> Yes, both of these options are necessary. What's your lspci -nv|grep -A1 0403?
>
debian-liv:/home/liviu# lspci -nv|grep -A1 0403
00:14.2 0403: 1002:4383
	Subsystem: 103c:1506
--
01:05.1 0403: 1002:960f
	Subsystem: 1002:960f

Best
Liviu
