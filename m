From: Pongi <pongi@pongi.it>
Subject: Re: Sound on Packard Bell V7900 (ALC260): where from
	here?
Date: Thu, 8 Mar 2007 16:00:57 +0000 (UTC)
Message-ID: <loom.20070308T165018-246@post.gmane.org>
References: <1165746566.14195.31.camel@osmosis>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andrea Gozzi <andrea.gozzi <at> linuxrevolution.eu> writes:

> 
> To the attention of ALSA Devel mailing list users.
> --------
> 
> It's now been several months since I bought my Packard Bell V7900 laptop
> but I was never able to hear any sound coming from its speakers.
> I tried every ALSA release from 1.12 to the latest 1.14rc1 but without
> any success.
> I tried loading the kernel modules with every possible option
> (hp,acer,fujitsu,..) but nothing from happened.The only useful result
> was to get sound coming from a jack marked "Line In" when snd-hda-intel
> is configured with 'model=test'.
> 
> Jonathan Woithe has been very helpful, I tried to explain to him as best
> as I could all the ALSA configurations tested and what I got from them.
> When I last heard from him he told me he believed that Packard Bell
> implemented some sort of amplifier between the Realtek chipset and the
> speakers.
> 
> It so seems to be a problem regarding only this particular model of
> laptop from PB.
> Since I don't have any experience dealing with this kind of situations
> who should I ask for support?
> Should I contact Packard Bell directly asking them for more information
> and/or some datasheets?Should I ask Realtek?
> Also, should I expect any help from them?
> 
> Thank you,
> 
> Andrea
> 

I'm still looking for a solution of this problem, and I just spotted this lonely
request for help. I sadly noticed that no one has replied neither saying "you
should not have buyed such bulky laptop" or "oh, sweetie, let's see what can be
done for you". I'm still without sound, and still can't see where to look for
solutions.

Driver developers, I can't send my laptop in to you to explore the weirdness of
the snd-hda-intel/packardbell, but I can send you an invite to join a ssh
session pointing directly to my linuxbox. Is it feasible? In april, when I will
be finally graduated, and when I will reinstall Ubuntu (format for Feisty!)
there will be a peep hole in my firewall to let some serious developer
investigate my laptop.

Beware, hacker out there, my box will be perfectly clean, with no cc numbers,
passwords or something and after the session I'll format the hd again, to ensure
there's no harming code left on my laptux.

.png






-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
