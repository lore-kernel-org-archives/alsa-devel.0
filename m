From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH v2 0/6] ARM: DaVinci: ASoC: Add
	mcasp	support for DM646x
Date: Fri, 17 Apr 2009 16:06:08 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017069809B11C@dbde02.ent.ti.com>
References: <1239921422-26729-1-git-send-email-naresh@ti.com>,
	<20090416125834.GR16318@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 33242243E3
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 12:38:43 +0200 (CEST)
In-Reply-To: <20090416125834.GR16318@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

Mark,

Thanks for the review.

I will re-submit the patches after fixing the comments.


Regards
Naresh
________________________________________
From: Mark Brown [broonie@sirena.org.uk]
Sent: Thursday, April 16, 2009 6:28 PM
To: Medisetty, Naresh
Cc: alsa-devel@alsa-project.org; davinci-linux-open-source@linux.davincidsp.com
Subject: Re: [alsa-devel] [PATCH v2 0/6] ARM: DaVinci: ASoC: Add mcasp  support for DM646x

On Thu, Apr 16, 2009 at 06:37:02PM -0400, Naresh Medisetty wrote:

> This patch set adds audio support for DM646x

Other than the comments I've posted (most of which are fairly minor)
this series looks good from an ASoC point of view.
