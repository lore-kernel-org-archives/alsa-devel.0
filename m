From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP advanced routing (matrix mixer)
Date: 06 Sep 2002 15:28:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1031318910.7294.26.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm considering writing an application to control the HDSP matrix mixer,
but so far I could only figure out how to route physical inputs to the
line out (First integer value (0-25) : input, second integer value
(26-27) : line out L-R, third integer value (0-65536) : gain). Paul,
could you please document a little the channel-to-output,
channel-to-line-out, and input-to-output cases ?

Thomas




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
