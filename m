From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Add a driver for AK4104
	S/PDIF	transmitter
Date: Mon, 9 Mar 2009 10:56:37 +0000
Message-ID: <20090309105633.GA13593@sirena.org.uk>
References: <1236554371-5911-1-git-send-email-daniel@caiaq.de>
	<1236561197-7968-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 06DB3103823
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 11:56:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236561197-7968-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2009 at 02:13:17AM +0100, Daniel Mack wrote:
> This adds a driver for the SPI connected AK4104 S/PDIF transmitter
> device. Its features are fairly simple, but as there is need to set up
> certain bits in the IEC958 information, this better goes into a real
> driver.

Applied, thanks.
