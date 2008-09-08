From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5] Permit simultaneous compilation of
	both PXA AC97 drivers
Date: Mon, 8 Sep 2008 11:35:09 +0100
Message-ID: <20080908103508.GF790@sirena.org.uk>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<20080908093047.GA790@sirena.org.uk> <48C4FC21.3060107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 373F524545
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 12:35:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C4FC21.3060107@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 08, 2008 at 02:19:13PM +0400, Dmitry Baryshkov wrote:

> Against which tree should I develop? 
> git://opensource.wolfsonmicro.com/linux-2.6-asoc ?

That or the topic/asoc or master branch of Takashi's tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

(the two should be in very close sync).
