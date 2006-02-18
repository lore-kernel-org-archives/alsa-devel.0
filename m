From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: EMU 1212m support - offer of assistance
Date: Sat, 18 Feb 2006 14:23:25 +0000
Message-ID: <ad2655cb0602180623l1715f05cq@mail.gmail.com>
References: <1140037298.c7bdf55cstefan.vassall@myrealbox.com>
	 <1140222070.2733.132.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1140222070.2733.132.camel@mindpipe>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: Stefan Vassall <stefan.vassall@myrealbox.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 18/02/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2006-02-15 at 21:01 +0000, Stefan Vassall wrote:
> > Is there any progress regarding the support of the EMU1212m and associa=
ted cards (0404/1820m)? There is a page on Alsa wiki (http://alsa.opensrc.o=
rg/EMU+1212m), and a text file from Dec 2005 that describes some significan=
t progress however there hasn't been any recent update.
> >
> > I have an Emu1212m and need to get it working under Linux - I am offeri=
ng any assistance to help.
>
> Please email James Courtier-Dutton (ask me off list if you need his
> address), he was working on this, but it's not going to be easy.  Do you
> have any previous experience writing Linux/ALSA drivers and/or reverse
> engineering Windows drivers?
>
> Lee
>

This card is a tough cookey to crack.
I have tried the simple approach of just reproducing all the IO port
calls made by the driver in windows, but this does not seem to be
enough.

The next step will have to be full disassembly and commenting of the
windows drivers.
Can you help with that task. I have not had time to start it, due to
hardware problems here. (no linux PC due to power surge)

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
