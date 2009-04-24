From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: Beagle: Add support for 4	channel
Date: Fri, 24 Apr 2009 10:49:52 +0100
Message-ID: <20090424094951.GB26440@sirena.org.uk>
References: <1240560201-10454-1-git-send-email-peter.ujfalusi@nokia.com>
	<1240560201-10454-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0761C103897
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 11:49:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1240560201-10454-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 11:03:21AM +0300, Peter Ujfalusi wrote:
> This patch adds support for the four channel TDM mode
> on Beagle board.
> 
> Depending on the channel count, the interface needs to be
> configured differently (I2S for stereo DSP_A for four channels)
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Looks good, I'll apply it - thanks!
