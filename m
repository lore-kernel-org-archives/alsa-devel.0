From: Volkan YAZICI <yazicivo@ttmail.com>
Subject: Re: Mic + Headphone Problem in Samsung R540
Date: Fri, 08 Oct 2010 16:11:15 +0300
Message-ID: <87y6a8de30.fsf_-_@alamut.ozu.edu.tr>
References: <87aams5t14.fsf@alamut.ozu.edu.tr>
	<87vd5cew6b.fsf@alamut.ozu.edu.tr> <4CAF104F.30201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.ttmail.com (mail.ttmail.com [88.255.235.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 52EFB243FB
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 15:10:48 +0200 (CEST)
In-Reply-To: <4CAF104F.30201@gmail.com> (Valentine Sinitsyn's message of "Fri,
	08 Oct 2010 18:36:31 +0600")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 08 Oct 2010, Valentine Sinitsyn <valentine.sinitsyn@gmail.com> writes:
> Looks like your Capture switch is disabled. Run alsamixer, find Capture (press
> F4) and then press Space to start capturing sound. Obviously, you will need to
> run arecord after that (I recommend using -vv to see the bar moving as you speak
> anything into mic).

Ok, this is not the first time I feel like a dumb. Thanks for the prompt
reply, it fixed the mic problem.

Can you say anything about the headphone problem? Plugging -in/-out
headphones doesn't have any effect.


Regards.
