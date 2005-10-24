From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Re: CMedia 8738 - problems running Jack
Date: Mon, 24 Oct 2005 14:55:23 -0700
Message-ID: <5bdc1c8b0510241455s1aaf8940gc408902fe06af8f@mail.gmail.com>
References: <5bdc1c8b0510240924w10e1a8d1o499e3739fd8e1923@mail.gmail.com>
	 <5bdc1c8b0510240932o6566fef2q96f1f2a5a970b771@mail.gmail.com>
	 <20051024202157.GA11137@meep>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051024202157.GA11137@meep>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Cunningham <spark@xdev.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/24/05, Dave Cunningham <spark@xdev.net> wrote:
> On Mon, Oct 24, 2005 at 09:32:24AM -0700, Mark Knecht wrote:
> >On 10/24/05, Mark Knecht <markknecht@gmail.com> wrote:
> >> Hi,
> >>    I am unable to file any bug reports with the Alsa bug system so I'm
> >> bringing the info here. Thanks in advance.
> >>
> >
> >Thanks to James and Lee this is now files as bug # 1496
> >
> >https://85.132.177.35/alsa-bug/view.php?id=3D1496
>
>
> I had and worked-around this problem, see
>
> http://boudicca.tux.org/hypermail/jackit-devel/this-month/0055.html
>
> i.e. run jack with the -o 2 parameter
>

Dave,
   Thanks very much. This does allow Jack to run in duplex mode
without crashing.

   Now, as things would have it, I cannot locate a cable to see if the
beast makes noise. Off to the store to buy one I guess.

   I'm not sure, in this case, how having more than 2 outputs would
serve me. As far as I can tell the machine only has a stereo output
jack. I have no idea where the other four would be used. Possibly
other machines provide a 5.1 output?

   Anyway, thanks.

Cheers,
Mark


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
