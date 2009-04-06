From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 0/5] ARM: DaVinci: ASoC: Add audio
	support	for DM646x
Date: Mon, 6 Apr 2009 12:53:54 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017069809B0E8@dbde02.ent.ti.com>
References: <1238723211-27329-1-git-send-email-naresh@ti.com>,
	<20090402154219.GM4527@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id EA2111037F1
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 09:26:12 +0200 (CEST)
In-Reply-To: <20090402154219.GM4527@sirena.org.uk>
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



I will re-submit the patches by taking care of all your comments



> On Thu, Apr 02, 2009 at 09:46:51PM -0400, Naresh Medisetty wrote:
>
> > This series is dependant on the following 3 patches submitted to the
> > DaVinci git:
>
> Am I right in thinking that there aren't any compile time dependencies
> on the DaVinci patches, only runtime ones?


Yes, there are no compile time dependencies on DaVinci patches submitted
to DaVinci list.





Thanks and Regards,
Naresh

________________________________________
From: Mark Brown [broonie@sirena.org.uk]
Sent: Thursday, April 02, 2009 9:12 PM
To: Medisetty, Naresh
Cc: alsa-devel@alsa-project.org; davinci-linux-open-source@linux.davincidsp.com
Subject: Re: [alsa-devel] [PATCH 0/5] ARM: DaVinci: ASoC: Add audio support     for DM646x

On Thu, Apr 02, 2009 at 09:46:51PM -0400, Naresh Medisetty wrote:

> This series is dependant on the following 3 patches submitted to the
> DaVinci git:

Am I right in thinking that there aren't any compile time dependencies
on the DaVinci patches, only runtime ones?
