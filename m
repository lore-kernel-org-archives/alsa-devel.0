From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: new alsa docs.
Date: Tue, 06 Aug 2002 18:25:22 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4F9602.7030804@boosthardware.com>
References: <20020805232519.H683@cebreiro.nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Andy Wingo <wingo@pobox.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andy Wingo wrote:
> On Tue, 06 Aug 2002, Patrick Shirkey wrote:
> 
> 
>>I'm have soreted out all the final bugs I had with the new docs setup. 
>>Added the midi stuff and I feel that the site is ready for prime time.
>>
>>You can see it here:
>>
>>http://www.alsa-project.org/alsa-doc/
> 
> 
> Rad!
> 
> I hadn't been keeping up with the status of your work, Patrick, but it
> looks great. Nice job.
> 

Thanks.

> A few suggestions, quibbles, etc, meant to be constructive feedback:
> 
> * It wasn't obvious to me that the "plus" down at the bottom is a link
> to add information. Perhaps if it were a link or a button that said
> something like "Add comment to this card's page..." or something it
> would be more clear.
> 

Ok. I stole it from the php site. I am trying to think of a new design 
that is funky. Probably a spin on the ALSA logo with ADD instead of ALSA.

> * I know you've got it templated, but I suppose that all of the common
> stuff on the card pages could maybe go on one separate page.
> 

We discussed this a while ago and the general consensus was that we 
wanted the page to be complete. I have tried to make a compromise 
between having the high level stuff easily accesible and not making it 
too scary for new users. The aim of the new setup is to provide a style 
of documentation which is similar to the way M$ does it. The sad truth 
is that is what the majority are used to so we want to make the 
transition easier for them.

I am open to other ways of presenting the material on the page.

> * Are there any programs that don't work with ~/.asoundrc files? I don't
> have one, personally. I just use the "default" device, as it suits my
> needs fine. I think that templated asoundrc isn't all that useful, but
> maybe that's just me.
> 

The .asoundrc is very simple for the main reason that we don't have 
working user docs for the .asoundrc file yet. I am working on it as are 
others. Watch this space. However the one in the template does work with 
  f.i ardour so that is useful for a lot of people.

> * It would be nice if the link to the driver docs were a link instead of
> a button. A table full of buttons is rather imposing, at least to me. I
> think it takes longer to render, too.
> 

I know but I haven't yet figured out how to make use a link as a submit 
button for a form which is the basis of the current design. Everything 
is posted around. I know there are better ways to do this but I don't 
know how to do them. So it will be form based until I or someone else 
can write a better version. Emphasis on write :)

> Anyway, what you have looks good, keep up the good work. These are just
> suggestions, take them or leave them as you will.
> 

I appreciate your feedback because it shows me which parts I need to 
work on.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
