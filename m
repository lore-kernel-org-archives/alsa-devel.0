From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Increasing maximum sampling frequency?
Date: Thu, 28 May 2009 14:12:55 +0200
Message-ID: <20090528121255.GJ14868@buzzloop.caiaq.de>
References: <4A1DED36.4030008@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DCE851038DC
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 14:12:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A1DED36.4030008@cse.unsw.edu.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2009 at 11:47:34AM +1000, Cameron Stone wrote:
> I've got a USB microphone application that I want to sample at 256000 8
> bit samples per second so I can listen to bats. I know that my device
> can get close to that rate, but alsa seems to restrict sampling rates to
> 192kHz.

Just out of curiosity - which microphone and what kind of codec are you
using for such frequencies?

Daniel
