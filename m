From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: Correct DSP/TDM mode (for twl4030 4 channel
	mode)
Date: Mon, 6 Apr 2009 11:11:39 +0100
Message-ID: <20090406101139.GB4057@sirena.org.uk>
References: <200904060957.43102.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FFF7243C6
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 12:11:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904060957.43102.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 06, 2009 at 09:57:43AM +0300, Peter Ujfalusi wrote:

> My bet goes to SND_SOC_DAIFMT_DSP_A, but I'm not 100% sure about it.

That does look right, yes.
