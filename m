From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] tlv320aic3x: control additions and cleanups
Date: Fri, 5 Dec 2008 13:12:56 +0000
Message-ID: <20081205131256.GC10489@sirena.org.uk>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
	<20081204183746.GB6628@sirena.org.uk>
	<20081204184751.GE21010@buzzloop.caiaq.de>
	<bd7b27490812050502o331d4f5dn2c9bbb3c4fd36169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C62A010381C
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 14:12:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <bd7b27490812050502o331d4f5dn2c9bbb3c4fd36169@mail.gmail.com>
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
Cc: u.luckas@road.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 05, 2008 at 03:02:20PM +0200, Jarkko Nikula wrote:

> I just checked & tested a fix which changes those "xxx DAC Playback Switch"
> to "xxx Playback Switch" are correct. That would also allow to develop new
> "xxx Playback Volume" controls and gain 9 dB more of output level :-)

So does the patch have your ack?
