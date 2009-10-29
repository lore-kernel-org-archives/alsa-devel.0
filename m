From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add APLL supply for the
	capture path
Date: Thu, 29 Oct 2009 11:11:40 +0000
Message-ID: <20091029111140.GA10275@rakim.wolfsonmicro.main>
References: <1256814352-22408-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FC1424689
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 12:11:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1256814352-22408-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2009 at 01:05:52PM +0200, Peter Ujfalusi wrote:
> Capture path also need the APLL enabled, adding DAPM_SUPPLY
> for the Virtual ADCs.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

I've queued this one up too.
