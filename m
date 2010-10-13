From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: tlv320dac33: Control for line
	output gain
Date: Wed, 13 Oct 2010 01:57:17 -0700
Message-ID: <20101013085717.GC29239@opensource.wolfsonmicro.com>
References: <1286960188-29334-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E768510385A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:57:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286960188-29334-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010 at 11:56:28AM +0300, Peter Ujfalusi wrote:
> New control to select the line output gain.
> This gain control affects the linein-to-lineout and
> dac-to-loneout gain differently.
> Use enum type to select the desired gain combination.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Looks good!

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
