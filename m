From: Arun KS <arunks@mistralsolutions.com>
Subject: Re: [PATCH 0/3] ASoC: multi-comp: OMAP platform fixes
Date: Sat, 7 Aug 2010 11:11:20 +0900
Message-ID: <AANLkTikYGPdzNtT5RWodct-xBZFbLO+UnwhxO9w6ias7@mail.gmail.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100806105628.2971f8a1.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F4BE24337
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 04:11:41 +0200 (CEST)
Received: by qyk1 with SMTP id 1so232137qyk.17
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 19:11:40 -0700 (PDT)
In-Reply-To: <20100806105628.2971f8a1.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, lrg@slimlogic.co.uk, jkrzyszt@tis.icnet.pl
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 6, 2010 at 4:56 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> Hi, notes for Arun and Janusz below.
>
> On Fri, =A06 Aug 2010 10:39:12 +0300
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
>
>> Hello,
>>
>> The following series introduces some cleanups for OMAP platforms in
>> multi-component branch.
>>
>> - Enable audio for OMAP1 class
>
> There's a on-going development going on to update ASoC framework. This
> multi-compont work requires major changes and our problem is that we
> don't have any OMAP1 boards to test these changes.
>
> We'd glad if you could test these changes with Peter's patches on OMAP1
> board.
Jarkko,

I m sorry to inform you that I m not having access to OSK anymore. It
was with my previous employer.

Arun
>
> The ASoC multi-component development happens in
> origin/topic/multi-component branch of this tree:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git
>
>
> --
> Jarkko
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
