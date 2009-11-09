From: Jonathan Leonard <jonathan.adams.leonard@gmail.com>
Subject: Re: RME HDSPe AIO
Date: Mon, 9 Nov 2009 11:56:55 -0800
Message-ID: <1401522d0911091156p55b1ad53m92f04933ccfa46f8@mail.gmail.com>
References: <mailman.2708.1257713283.2074.alsa-devel@alsa-project.org>
	<000301ca60ba$afccd260$0f667720$@net> <4AF7E71B.2030808@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 13F59243D2
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 20:56:57 +0100 (CET)
Received: by bwz9 with SMTP id 9so13733424bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 09 Nov 2009 11:56:55 -0800 (PST)
In-Reply-To: <4AF7E71B.2030808@faberman.de>
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

Florian, why can't you answer his technical question with specifics?  What
in ALSA prevents professional use?  There is a culture out there that
'worships' whatever professional means without ever defining it.  It is
elitism and in a technical forum unforgivable.  Lets leave culture out of
driver discussions ok?  I asked for information about how to make the AIO
work in ALSA and I have received ZERO useful information and instead got
discouraging and arrogant responses.  I feel like I am being neutralized
here.  The soundcard matrix contains no entries for the AIO, so one can only
conclude ambiguity.

I am willing to try and help, but without useful information it is difficult
to proceed.

The HDSPe hostcard works great with the multiface.  I am working on the
assumption that if the card can be identified differently, there will be a
similar level of functionality.  There is also the benefit of hdspmixer and
hdspconf, both which work fine with HDSPe hostcard and multiface.  If there
is a reason this is not appropriate, technically, that can be validated I
would like to hear it.  Otherwise if ALSA and the operating system can be
adjusted to load the snd-hdsp module instead, I would like to know how to
make this accommodation and how to compile ALSA to make this possible.  I
have great hopes for a snd-hdspm module that will support all the new gear,
but that may never happen.  In the meantime, I think it is acceptable to use
the existing module even if it is not perfect.  If perfection were a
requirement ALSA would not have gotten very far and neither would science.

So again I will try and ask the experts of ALSA development how to make
these accommodations.

jonathan adams leonard

On Mon, Nov 9, 2009 at 1:55 AM, Florian Faber <faber@faberman.de> wrote:

> Demian,
>
> > The Trinnov room correction system which is a pro market product uses
> > Hammerfall cards and Alsa to do some very ambitious pro audio functions
> for
> > example.
>
> It is nice if everything works out for you. But there are other people
> who need different things.
>
>
> Flo
>
