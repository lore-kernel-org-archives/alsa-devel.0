From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] SoC WM8940 Driver
Date: Mon, 27 Apr 2009 20:58:44 +0100
Message-ID: <20090427195844.GB14626@sirena.org.uk>
References: <49F21310.4060009@cam.ac.uk> <20090425102100.GA4394@sirena.org.uk>
	<49F345A8.1030901@cam.ac.uk> <20090425180346.GA4072@sirena.org.uk>
	<49F599BB.9050805@cam.ac.uk> <20090427122550.GF1760@sirena.org.uk>
	<49F5A69C.40406@cam.ac.uk> <49F5B7F8.1010103@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 92750103809
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 21:58:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49F5B7F8.1010103@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 01:49:44PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> aSoC: Initial support for the Wolfson Micro WM8940 codec

ASoC.

I've applied this, thanks!  I've also applied a commit staticising the
TLV values - these aren't exported from the driver.
