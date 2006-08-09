From: Christoph Lameter <christoph@lameter.com>
Subject: Re: cmipci driver locking up linux hard
Date: Tue, 8 Aug 2006 17:20:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608081719350.2302@graphe.net>
References: <Pine.LNX.4.64.0608041616590.9917@graphe.net>
	<s5hy7u0raux.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608070927480.3308@graphe.net>
	<s5hhd0os9nv.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608071318580.7499@graphe.net>
	<s5hhd0nr2va.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608081713040.2054@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0608081713040.2054@graphe.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Aug 2006, Christoph Lameter wrote:

> Did that at the same time as adding the printk part. Will now take out the 
> printk to see if it still works.

System hangs on X startup. All screens are grey (background) and I hear a 
murmuring sound from the speakers. wirr wirr wirr. The murmuring sound 
continues until I reset the system.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
