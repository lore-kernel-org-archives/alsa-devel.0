From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Subject: Re: Issue with Alsa and PulseAudio
Date: Wed, 11 Feb 2009 06:49:48 +0000 (UTC)
Message-ID: <loom.20090211T064642-985@post.gmane.org>
References: <BAY102-W3417CC50075C3DE003B2F68A660@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C2F7103860
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 07:55:04 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LX8zv-00012z-4k
	for alsa-devel@alsa-project.org; Wed, 11 Feb 2009 06:55:03 +0000
Received: from SantaYnez-17-132.resnet.ucsb.edu ([169.231.17.132])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 06:55:03 +0000
Received: from ludovico.cavedon by SantaYnez-17-132.resnet.ucsb.edu with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 06:55:03 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Ash <hashbrown100 <at> hotmail.com> writes:
> When I am setting up my hw params, and I call snd_pcm_hw_params_any(), I get
an "Operation not permitted"
> error. I am not sure why this is happening, anyone else see this before? I am
using pulseaudio version 0.9.9
> and alsa 1.0.16.

did you figure out what the problem was?
I am having the same problem under Ubuntu, alsa-lib 1.0.17 and pulseaudio 0.9.10.

Thank you in advance,
Ludovico
