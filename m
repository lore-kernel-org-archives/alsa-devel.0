From: "Cody Jung" <funkycat32@gmail.com>
Subject: Re: ALSA Newbie - Getting Ensoniq SoundscapeVivo to
	work?
Date: Sat, 28 Apr 2007 10:56:54 -0500
Message-ID: <d382e1990704280856j533b89d4wc8ee45d949704aa6@mail.gmail.com>
References: <d382e1990704272206y9712a84x1e07d07eda58fb18@mail.gmail.com>
	<463319CA.4040309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <463319CA.4040309@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I tested that when I acquired it a while ago and if I remember correctly, it
> just worked... mmm. come to think of it, it might be the case that I needed
> to add its PnP ID to the driver. Not sure anymore. Could you confirm whether
> or not your Soundscape is an ISA-PnP card and if so (that's also a way to
> find out if you don't know if it is) run "pnpdump" with it installed and
> look for a PnP-ID for the card in it? Something of the form "ENSxxxx".

There was a Vendor Id (ENS4081) and two Logical device Ids (ENS1011
and ENS2020).

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
