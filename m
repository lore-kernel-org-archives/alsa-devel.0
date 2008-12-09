From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: How to write a PXA CPU
Date: Tue, 9 Dec 2008 09:53:17 +0000
Message-ID: <20081209095314.GB1630@sirena.org.uk>
References: <fd90355f0812081916u34058f77pa0ead68a1ab93aae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 26430103807
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 10:53:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fd90355f0812081916u34058f77pa0ead68a1ab93aae@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juan Pablo G?mez <juanwalker@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 09, 2008 at 04:16:07AM +0100, Juan Pablo G?mez  wrote:

> Hi, I'm looking for documentation that explains me how to write a PXA
> document. It's for a NIOS 2 processor in an altera De2 board.

What do you mean by a "PXA document"?  There is support for the AC97 and
SSP and I2S interfaces of the PXA CPUs in sound/soc/pxa if that's what
you're looking for.
