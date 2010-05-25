From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Tue, 25 May 2010 11:39:57 +0200
Message-ID: <20100525093957.GC30801@buzzloop.caiaq.de>
References: <1274299579-12990-1-git-send-email-wdev@foltman.com>
	<4BF4E440.9030105@ladisch.de> <4BF4E97A.9020209@foltman.com>
	<4BF4FF32.8080206@ladisch.de> <4BFB9346.4050701@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 523AC2439E
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 11:40:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BFB9346.4050701@foltman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Foltman <wdev@foltman.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, May 25, 2010 at 10:07:18AM +0100, Krzysztof Foltman wrote:
> On 20/05/10 10:21, Clemens Ladisch wrote:
> 
> > The comments in this file are usually only about the protocol itself,
> > because this is what the driver needs to know.
> 
> Okay. Any comments about the 20 May version of the patch? It has the 
> output routine almost completely rewritten, and the comments are limited 
> to essential stuff (anyone can now find the previous version with 
> protocol description by googling mpd16 protocol, so it should be OK).

It's commited already, see

  http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=summary

Daniel
