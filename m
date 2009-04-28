From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Setting the AC97 private data
Date: Tue, 28 Apr 2009 20:59:42 +0100
Message-ID: <20090428195942.GA10325@sirena.org.uk>
References: <9e4733910904280951t3f03f8c4p44e4a7025ebb7ef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D523524561
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 21:59:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904280951t3f03f8c4p44e4a7025ebb7ef1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 12:51:31PM -0400, Jon Smirl wrote:

> Is there some easier way to set this data?

Not particuarly; only one AC97 controller is supported at once.
