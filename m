From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: documentation or lack thereof
Date: Mon, 09 Dec 2002 11:23:12 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18LQai-0006m2-00@sc8-sf-list1.sourceforge.net>
References: <3DF4AE92.3010206@monmouth.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 09 Dec 2002 09:54:10 EST."
             <3DF4AE92.3010206@monmouth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John S. Denker" <jsd@monmouth.com>
Cc: Takashi Iwai <tiwai@suse.de>, Uros Bizjak <uros@kss-loka.si>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >actually, i have to note that this is not so obvious. there are *many*
> >people using ALSA. we've all sworn our way through the process.
> >there is *no* point in reminding this list about the need for
> >documentation. the current state is pitiful, ...
> >  many folks seem to think there is a
> >large group of people working on ALSA: there is not.
>
>I have tried and failed to understand that remark.  I
>stumble over the following apparent inconsistencies:
>  ++ On one hand we agree that the current state is pitiful.
>  ++ I would think and hope that reminders are almost
>     unnecessary because the pitifulness is so obvious.
>  -- But why start out by saying it is not obvious?

because its not clear to me that a lot more people would be using ALSA
today if it had been better documented over the last year or so. the
central problems with using ALSA over the last 12-18 months have not
really been lack of documentation but lack of API stability.

>  -- Usually swearing is not considered a good thing.

and it wasn't this time either. my point was merely that quite a
number of us having written applications of varying degrees of
sophistication around ALSA without any documentation. it was painful,
very painful during the time that jaroslav and abramo kept changing
the API, but it has become a lot less so nowadays. the problem is
there is still no documentation to make it easier for people starting
to use ALSA now, and those of us who have figured it out no longer
have the motivation to write it.

>  -- And note that if the documentation were better,
>     more people would be willing and able to help
>     work on the project!  In a collaborative project,
>     lack of documentation and short-handedness create
>     a vicious circle!

i disagree. there seem to be very few people interested in working on
alsa-kernel or alsa-lib. most people want a nice, easy to use API so
that they can dump sounds to an audio interface or possibly record
them. the number of people with the skills, knowledge and interest in
working on ALSA has always been remarkably low.

on the other hand, having more documentation is almost always a good
thing. now, where are the volunteers?

--p






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
